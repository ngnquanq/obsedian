# IIQ Analyst Playbook: Business Questions → SQL Answers

This document maps common business questions to SQL queries against the IIQ database. Each recipe includes the question, business context, SQL, how to read the results, and variations. All queries use the join paths and patterns from [IIQ.md](IIQ.md), the field values from [IIQ-Field-Values.md](IIQ-Field-Values.md), and the process knowledge from [IIQ-Data-Flows.md](IIQ-Data-Flows.md).

**Conventions used throughout:**
- All queries filter on `correlated = 1 AND is_workgroup = 0` unless orphan accounts or workgroups are specifically needed
- Timestamps use Oracle conversion syntax — see [IIQ.md — Timestamp conversion](IIQ.md#timestamp-conversion-is-mandatory-for-every-date-column) for MySQL and SQL Server equivalents
- `/* filter */` comments mark where you should add environment-specific filters

---

## 1. Access Inventory

### Who has access to what? (Per-person access report)

**Context**: The most fundamental IAM question. Combines identity, account, and entitlement data into a single view.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    app.name AS application,
    l.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ma.display_name AS entitlement_display_name,
    CASE WHEN ie.assigned = 1 THEN 'Assigned' ELSE 'Aggregated' END AS origin,
    CASE WHEN ie.granted_by_role = 1 THEN 'Yes' ELSE 'No' END AS from_role,
    ie.aggregation_state
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_link l ON l.identity_id = i.id AND l.application = ie.application
LEFT JOIN spt_managed_attribute ma
    ON ma.application = ie.application
    AND ma.value = ie.value
    AND ma.attribute = ie.name
WHERE i.correlated = 1 AND i.is_workgroup = 0
  /* filter: AND i.name = 'jsmith' */
ORDER BY i.name, app.name, ie.value;
```

**How to read**: Each row is one entitlement held by one person on one application. The `origin` column tells you if it was explicitly assigned or just found during aggregation. Check `aggregation_state` — `Disconnected` means the entitlement was not found on the last aggregation.

### Per-application access report

**Context**: Application owners need to know who has access to their system.

```sql
SELECT
    app.name AS application,
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    l.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ie.aggregation_state
FROM spt_application app
JOIN spt_identity_entitlement ie ON app.id = ie.application
JOIN spt_identity i ON ie.identity_id = i.id
LEFT JOIN spt_link l ON l.identity_id = i.id AND l.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND app.name = 'Active Directory' /* filter: your app name */
  AND ie.aggregation_state = 'Connected'
ORDER BY i.name, ie.value;
```

### Orphan accounts (uncorrelated)

**Context**: Accounts that IIQ could not match to a known identity. These are security risks — they may belong to former employees, shared accounts, or test accounts.

```sql
SELECT
    app.name AS application,
    l.native_identity AS account_id,
    l.display_name AS account_display_name,
    i.name AS placeholder_identity,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (l.last_refresh / 1000 / 86400) AS last_aggregated
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE i.correlated = 0
ORDER BY app.name, l.native_identity;
```

**Variation — Count by application:**

```sql
SELECT
    app.name AS application,
    COUNT(*) AS orphan_account_count
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE i.correlated = 0
GROUP BY app.name
ORDER BY orphan_account_count DESC;
```

### Service accounts

**Context**: Non-human accounts that need separate governance. Depending on your configuration, these may be identified by `spt_identity.type` or by naming convention.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.type,
    app.name AS application,
    l.native_identity AS account_id,
    COUNT(ie.id) AS entitlement_count
FROM spt_identity i
JOIN spt_link l ON i.id = l.identity_id
JOIN spt_application app ON l.application = app.id
LEFT JOIN spt_identity_entitlement ie ON i.id = ie.identity_id AND ie.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND (i.type = 'Service' OR i.name LIKE 'svc_%') /* adjust to your naming convention */
GROUP BY i.name, i.display_name, i.type, app.name, l.native_identity
ORDER BY entitlement_count DESC;
```

### Identities with the most entitlements (excessive access)

**Context**: Identifies potential over-provisioned users for targeted review.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    mgr.name AS manager,
    COUNT(ie.id) AS total_entitlements,
    COUNT(DISTINCT ie.application) AS application_count
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 0
  AND ie.aggregation_state = 'Connected'
GROUP BY i.name, i.display_name, i.extended2, mgr.name
ORDER BY total_entitlements DESC
FETCH FIRST 50 ROWS ONLY; /* Oracle; use LIMIT 50 for MySQL */
```

---

## 2. Access Origin and Lineage

### How did someone get this access?

**Context**: Auditors frequently ask "why does this person have this entitlement?" Tracing the origin requires checking requests, roles, and aggregation.

```sql
SELECT
    ie.value AS entitlement_value,
    ie.name AS entitlement_attribute,
    app.name AS application,
    ie.source,
    CASE
        WHEN ie.assigned = 1 AND ie.granted_by_role = 1 THEN 'Assigned via role'
        WHEN ie.assigned = 1 AND ie.granted_by_role = 0 THEN 'Directly requested'
        WHEN ie.assigned = 0 AND ie.granted_by_role = 1 THEN 'Detected role match'
        ELSE 'Found on system (aggregated)'
    END AS access_origin,
    ie.aggregation_state,
    ir.name AS request_id,
    ir.requester_display_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS request_date
FROM spt_identity_entitlement ie
JOIN spt_identity i ON ie.identity_id = i.id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_identity_request_item iri ON ie.request_item = iri.id
LEFT JOIN spt_identity_request ir ON iri.identity_request_id = ir.id
WHERE i.name = 'jsmith' /* filter: target identity */
ORDER BY app.name, ie.value;
```

### Who approved this access?

**Context**: Traces from an entitlement back through the request to the approver.

```sql
SELECT
    ir.name AS request_id,
    ir.type AS request_type,
    ir.requester_display_name AS requester,
    ir.target_display_name AS target,
    iri.name AS attribute_name,
    iri.value AS attribute_value,
    iri.operation,
    iri.approver_name,
    iri.approval_state,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS request_date,
    ir.completion_status
FROM spt_identity_request ir
JOIN spt_identity_request_item iri ON ir.id = iri.identity_request_id
WHERE ir.target_display_name = 'Jane Smith' /* filter: target identity display name */
ORDER BY ir.created DESC;
```

### What role grants this entitlement?

**Context**: Maps from a specific entitlement back to the role(s) that include it in their profile.

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name AS role_display_name,
    app.name AS application,
    pc.elt AS entitlement_filter_xml
FROM spt_bundle b
JOIN spt_profile p ON b.id = p.bundle_id
JOIN spt_application app ON p.application = app.id
JOIN spt_profile_constraints pc ON p.id = pc.profile
WHERE b.disabled = 0
  AND app.name = 'Active Directory' /* filter: your application */
  /* To find roles containing a specific entitlement, examine pc.elt XML */
ORDER BY b.type, b.name;
```

**Practical notes**: The `pc.elt` column contains XML Filter definitions that may use complex matching (equality, substring, regex). You may need to parse this CLOB to determine exact entitlement matching criteria.

---

## 3. Change Analysis

### Who joined since a given date?

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    i.type,
    mgr.name AS manager,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (i.created / 1000 / 86400) AS created_date
FROM spt_identity i
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND i.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  /* adjust date above to your target date */
ORDER BY i.created DESC;
```

### Who left since a given date?

**Context**: Leavers are marked `inactive = 1`. Cross-reference with `spt_link` to check cleanup status.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (i.modified / 1000 / 86400) AS modified_date,
    COUNT(l.id) AS remaining_accounts,
    SUM(CASE WHEN ie.aggregation_state = 'Connected' THEN 1 ELSE 0 END) AS connected_entitlements
FROM spt_identity i
LEFT JOIN spt_link l ON i.id = l.identity_id
LEFT JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 1
  AND i.modified > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
GROUP BY i.name, i.display_name, i.extended2, i.modified
ORDER BY i.modified DESC;
```

**How to read**: `remaining_accounts > 0` or `connected_entitlements > 0` for leavers means cleanup is incomplete.

### Provisioning actions in a time window

```sql
SELECT
    pt.identity_name,
    pt.application_name,
    pt.native_identity,
    pt.operation,
    pt.source,
    pt.status,
    pt.type AS provisioning_type,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400) AS action_date
FROM spt_provisioning_transaction pt
WHERE pt.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  AND pt.created < (TO_DATE('2026-04-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  /* adjust date range above */
ORDER BY pt.created DESC;
```

**Variation — Provisioning summary by operation and status:**

```sql
SELECT
    pt.operation,
    pt.status,
    pt.source,
    COUNT(*) AS action_count
FROM spt_provisioning_transaction pt
WHERE pt.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
GROUP BY pt.operation, pt.status, pt.source
ORDER BY action_count DESC;
```

### Point-in-time access reconstruction

**Context**: An auditor, regulator, or investigator asks "what logical access did each employee have on date `T`?" IIQ's cube tables (`spt_identity_entitlement`, `spt_link`, etc.) are **mutable current-state stores** — each aggregation overwrites the previous values, with no historical preservation. (See [IIQ-Concepts.md — Current-state, not real-time and not historical](IIQ-Concepts.md#current-state-not-real-time-and-not-historical) for why this matters.) Reconstruction is possible but the approach depends on what your deployment retains in its **archive layer** or **event layer**. Choose by decision tree:

```
Q: Does spt_identity_snapshot contain rows on or before T?
   YES  → Approach A: parse the snapshot XML        (most accurate)
   NO   → Q: Does spt_certification_archive cover T?
          YES  → Approach B: extract from cert archive (coarse but reliable, scoped)
          NO   → Q: Does spt_provisioning_transaction retention reach T?
                 YES  → Approach C: reverse-walk current state with deltas
                 NO   → Reconstruction is NOT POSSIBLE from IIQ alone.
                        Fall back to target-system audit logs.
```

#### Step 1 — Pre-flight: confirm retention covers your target date

Run **before** promising anything to the requester. If the oldest row in any source is *after* `T`, that source can't help.

```sql
/* (A) Identity snapshots — best source if enabled */
SELECT 'identity_snapshot' AS source, COUNT(*) AS row_count,
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400) AS oldest,
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400) AS newest
FROM spt_identity_snapshot
UNION ALL
SELECT 'certification_archive', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_certification_archive
UNION ALL
SELECT 'provisioning_transaction', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_provisioning_transaction
UNION ALL
SELECT 'audit_event', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_audit_event;
```

#### Approach A — Identity snapshot (best case)

Use when `spt_identity_snapshot` has rows on or before `T`. For each identity, find the most recent snapshot at or before `T` and parse the embedded XML.

```sql
/* Find the closest snapshot per identity at or before the target date.
   Replace <TARGET_EPOCH_MS> with: 
     (TO_DATE('2026-01-31','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
*/
WITH closest AS (
    SELECT s.identity_id, MAX(s.created) AS snapshot_created
    FROM   spt_identity_snapshot s
    WHERE  s.created <= <TARGET_EPOCH_MS>
    GROUP  BY s.identity_id
)
SELECT
    i.name                                                                AS identity_name,
    i.display_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (s.created / 1000 / 86400)       AS snapshot_date,
    s.attributes                                                          AS snapshot_xml /* CLOB — parse below */
FROM spt_identity_snapshot s
JOIN closest      c ON c.identity_id = s.identity_id AND c.snapshot_created = s.created
JOIN spt_identity i ON s.identity_id = i.id
WHERE i.correlated = 1 AND i.is_workgroup = 0;
```

Then parse the snapshot XML to extract account-level entitlements. Schemas vary slightly by version — validate the path against one sample row before bulk-parsing:

```sql
/* Oracle XMLTABLE parse — adjust XPath for your snapshot schema.
   The typical structure is:
     <IdentitySnapshot>
       <links>
         <AccountSnapshot application="...">
           <attributes><Map><entry key="..."><value>...</value></entry></Map></attributes>
         </AccountSnapshot>
       </links>
     </IdentitySnapshot>
*/
SELECT
    i.name                                                                AS identity_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (s.created / 1000 / 86400)       AS snapshot_date,
    xt.application,
    xt.attribute_name,
    xt.attribute_value
FROM spt_identity_snapshot s
JOIN spt_identity i ON s.identity_id = i.id,
     XMLTABLE(
         '/IdentitySnapshot/links/AccountSnapshot/attributes/Map/entry'
         PASSING xmltype(s.attributes)
         COLUMNS
             application     VARCHAR2(256)  PATH 'ancestor::AccountSnapshot/@application',
             attribute_name  VARCHAR2(256)  PATH '@key',
             attribute_value VARCHAR2(2000) PATH 'value'
     ) xt
WHERE s.created BETWEEN <TARGET_EPOCH_MS> - 86400000 AND <TARGET_EPOCH_MS>
ORDER BY identity_name, application, attribute_name;
```

**Practical notes**: XML parsing across millions of CLOBs is slow — stage the result into a flat reporting table once, query that. Only group memberships and role-related attributes are usually needed; filter `attribute_name IN ('memberOf', 'groups', 'roles', ...)` to your environment's relevant entitlement attributes.

#### Approach B — Certification archive (coarse fallback)

Use when no snapshot exists but a certification campaign was archived around `T`. Each archive captures who had what *within campaign scope* at campaign start.

```sql
/* List archives near T to pick the most relevant one */
SELECT
    ca.name                                                                AS campaign_name,
    ca.parent                                                              AS definition_id,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ca.created / 1000 / 86400)       AS archive_date,
    LENGTH(ca.contents)                                                    AS archive_xml_size
FROM spt_certification_archive ca
WHERE ca.created BETWEEN <TARGET_EPOCH_MS> - 90 * 86400000
                     AND <TARGET_EPOCH_MS> + 90 * 86400000
ORDER BY ABS(ca.created - <TARGET_EPOCH_MS>);
```

Then parse `ca.contents` (compressed XML — your DBA may need to decompress with `UTL_COMPRESS` or equivalent first):

```sql
/* Adjust XPath for your IIQ version. Items live at:
   /CertificationArchive/Certification/items/CertificationItem
   with attributes describing the entitlement under review. */
SELECT
    ca.name AS campaign_name,
    xt.reviewed_identity,
    xt.application,
    xt.attribute_name,
    xt.attribute_value,
    xt.action_status                                  /* Approved/Remediated when decided */
FROM spt_certification_archive ca,
     XMLTABLE(
         '//CertificationItem'
         PASSING xmltype(ca.contents)
         COLUMNS
             reviewed_identity VARCHAR2(256)  PATH '@parent',
             application       VARCHAR2(256)  PATH 'exceptionEntitlements/Permission/@application',
             attribute_name    VARCHAR2(256)  PATH 'exceptionEntitlements/Permission/@target',
             attribute_value   VARCHAR2(2000) PATH 'exceptionEntitlements/Permission/rights',
             action_status     VARCHAR2(64)   PATH 'action/@status'
     ) xt
WHERE ca.id = '<archive_id_from_previous_query>';
```

**How to read**: an entitlement appearing in the archive means the holder had it at campaign-creation time. **Caveat**: only entitlements *in the campaign scope* are present — out-of-scope applications are invisible.

#### Approach C — Reverse-walk current state with provisioning deltas

The most common workable approach when neither snapshot nor archive exists. Take today's state and back out every change that happened between `T` and now.

```sql
/* Step C1: Stage current state. This is your starting point. */
CREATE TABLE rpt_pit_current AS
SELECT
    i.name        AS identity_name,
    app.name      AS application_name,
    ie.name       AS attribute_name,
    ie.value      AS attribute_value,
    'CURRENT'     AS state_source
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
JOIN spt_application app ON ie.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND ie.aggregation_state = 'Connected';

/* Step C2: Stage successful provisioning deltas in (T, NOW].
   pt.attribute_request is a CLOB containing an AttributeRequest XML.
   Typical structure:
     <AttributeRequest name="memberOf" op="Add" value="CN=SAP_Approvers,..."/>
*/
CREATE TABLE rpt_pit_deltas AS
SELECT
    pt.identity_name,
    pt.application_name,
    pt.native_identity,
    pt.operation                                                           AS account_op,    /* Create/Modify/Delete */
    xt.attr_name,
    xt.attr_op                                                             AS entitlement_op, /* Add/Remove/Set */
    xt.attr_value,
    pt.status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400)       AS action_date
FROM spt_provisioning_transaction pt,
     XMLTABLE(
         '//AttributeRequest'
         PASSING xmltype(pt.attribute_request)
         COLUMNS
             attr_name  VARCHAR2(256)  PATH '@name',
             attr_op    VARCHAR2(32)   PATH '@op',
             attr_value VARCHAR2(2000) PATH '@value'
     ) xt
WHERE pt.status = 'Committed'
  AND pt.created > <TARGET_EPOCH_MS>
  AND pt.created <= (SYSDATE - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000;

CREATE INDEX ix_pit_deltas ON rpt_pit_deltas(identity_name, application_name, attr_name, attr_value);

/* Step C3: Reconstruct T-state. Logic:
     T_state = CURRENT
              MINUS  every (Add) between T and NOW   /* shouldn't have been there at T */
              UNION  every (Remove) between T and NOW /* should have been there at T */
*/
CREATE TABLE rpt_pit_reconstructed AS
SELECT identity_name, application_name, attribute_name AS attr_name, attribute_value AS attr_value
FROM   rpt_pit_current
MINUS
SELECT identity_name, application_name, attr_name, attr_value
FROM   rpt_pit_deltas
WHERE  entitlement_op = 'Add'
UNION
SELECT identity_name, application_name, attr_name, attr_value
FROM   rpt_pit_deltas
WHERE  entitlement_op = 'Remove';

/* Step C4: Final answer */
SELECT * FROM rpt_pit_reconstructed
WHERE identity_name = 'jsmith' /* filter as needed */
ORDER BY identity_name, application_name, attr_name;
```

**How to read**: each row in `rpt_pit_reconstructed` represents an entitlement the identity *should have held* on date `T`, based on IIQ's record of changes since then.

**Practical notes**:
- `pt.attribute_request` XML schema varies — check one row of your data and adjust the XPath in Step C2.
- For account-level events (`pt.operation IN ('Create','Delete')`), an account creation after `T` means the entire `spt_link` shouldn't have existed at `T`; an account deletion after `T` means the account's last-known entitlements should be added back. Handle these cases separately from per-attribute deltas.
- Modifications to identity attributes (department, manager) need `spt_audit_event` to reverse — provisioning transactions only cover account/entitlement deltas.
- Performance: stage everything, never join `spt_provisioning_transaction` directly to `spt_identity_entitlement` in a single query.

#### The blind spot — disclose this to the requester

> [!warning] Reconstruction is not forensic-grade
> Whichever approach you use, reconstruction has a **fundamental gap**: any change made directly on a target system (an AD admin manually adding a user to a group, an SAP basis admin granting a transaction code) **bypasses IIQ entirely**. It only surfaces when the next aggregation runs, with no event timestamp other than "discovered at aggregation time T+n." The reconstruction will be wrong for any window that contains direct-target activity.
>
> **Disclosure template for the requester:**
>
> > *"The reconstruction reflects logical access as recorded by IIQ, based on \[snapshot / certification archive / current state ± provisioning deltas]. Direct administrative changes made on the target systems outside the IIQ workflow are not captured here and may have caused brief discrepancies between actual access and recorded access during the requested window. For forensic-grade reconstruction, this output must be combined with the target systems' own audit logs (AD security events, SAP change documents, database audit trails)."*

#### Reconstruction sanity check

Always validate before delivering. Pick five identities at known life-cycle moments (a recent joiner, a recent leaver, a recent role assignment, a recent role removal, a long-tenured stable user) and inspect their reconstructed state by hand against the source events:

```sql
/* For one identity, list every event that contributed to its reconstruction */
SELECT
    'PROVISIONING' AS source,
    pt.application_name,
    pt.operation,
    pt.status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400) AS event_date
FROM spt_provisioning_transaction pt
WHERE pt.identity_name = 'jsmith'
  AND pt.created > <TARGET_EPOCH_MS>
UNION ALL
SELECT
    'AUDIT' AS source,
    ae.application,
    ae.action,
    ae.string1,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ae.created / 1000 / 86400)
FROM spt_audit_event ae
WHERE ae.target = 'jsmith'
  AND ae.created > <TARGET_EPOCH_MS>
ORDER BY event_date;
```

If the reconstructed state for the test identities doesn't match what their lifecycle history suggests, your XPath is wrong, your `T` boundary is off-by-one, or a retention purge has eaten data you assumed was present.

---

### Roles created or modified recently

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name,
    b.disabled,
    b.requestable,
    owner.name AS owner,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (b.created / 1000 / 86400) AS created_date,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (b.modified / 1000 / 86400) AS modified_date
FROM spt_bundle b
LEFT JOIN spt_identity owner ON b.owner = owner.id
WHERE b.modified > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY b.modified DESC;
```

---

## 4. Certification Analytics

### Campaign completion rate

**Context**: How far along is each certification campaign? This is the primary tracking metric for compliance teams.

```sql
SELECT
    cd.name AS campaign_name,
    c.short_name AS cert_name,
    c.manager AS reviewer,
    c.phase,
    c.total_entities,
    c.completed_entities,
    c.percent_complete AS entity_pct,
    c.total_items,
    c.completed_items,
    c.item_percent_complete AS item_pct,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.activated / 1000 / 86400) AS start_date,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.expiration / 1000 / 86400) AS due_date
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
ORDER BY c.activated DESC;
```

### Completion by department (for manager certifications)

```sql
SELECT
    i.extended2 AS reviewer_department,
    COUNT(c.id) AS cert_count,
    AVG(c.item_percent_complete) AS avg_item_completion,
    SUM(CASE WHEN c.phase = 'Signed' THEN 1 ELSE 0 END) AS signed_count,
    SUM(CASE WHEN c.phase = 'Active' AND c.expiration < (SYSDATE - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
        THEN 1 ELSE 0 END) AS overdue_count
FROM spt_certification c
JOIN spt_identity i ON i.name = c.manager
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
WHERE i.correlated = 1
  /* filter: AND cd.name = 'Q1 2026 Manager Review' */
GROUP BY i.extended2
ORDER BY avg_item_completion ASC;
```

### Overdue certifications

```sql
SELECT
    cd.name AS campaign_name,
    c.short_name AS cert_name,
    c.manager AS reviewer,
    c.phase,
    c.item_percent_complete,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.expiration / 1000 / 86400) AS due_date,
    ROUND((SYSDATE - (TO_DATE('1970-01-01','YYYY-MM-DD') + (c.expiration / 1000 / 86400)))) AS days_overdue
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
WHERE c.phase IN ('Active', 'Challenge')
  AND c.expiration < (SYSDATE - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY days_overdue DESC;
```

### Approve vs. revoke ratio

**Context**: A reviewer who approves 100% of items raises audit concerns ("rubber-stamping"). Conversely, extremely high revocation rates may indicate a poorly scoped campaign.

```sql
SELECT
    c.manager AS reviewer,
    cd.name AS campaign_name,
    COUNT(ca.id) AS total_decisions,
    SUM(CASE WHEN ca.status = 'Approved' THEN 1 ELSE 0 END) AS approved,
    SUM(CASE WHEN ca.status = 'Remediated' THEN 1 ELSE 0 END) AS revoked,
    SUM(CASE WHEN ca.status = 'Mitigated' THEN 1 ELSE 0 END) AS mitigated,
    SUM(CASE WHEN ca.status = 'Delegated' THEN 1 ELSE 0 END) AS delegated,
    ROUND(SUM(CASE WHEN ca.status = 'Approved' THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(ca.id), 0), 1) AS approval_rate_pct
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
JOIN spt_certification_entity ce ON ce.certification_id = c.id
JOIN spt_certification_item ci ON ci.certification_entity_id = ce.id
JOIN spt_certification_action ca ON ca.id = ci.action
GROUP BY c.manager, cd.name
ORDER BY approval_rate_pct DESC;
```

### Average turnaround time per reviewer

```sql
SELECT
    c.manager AS reviewer,
    cd.name AS campaign_name,
    COUNT(ca.id) AS decisions_made,
    ROUND(AVG(ca.decision_date - c.activated) / 1000 / 86400, 1) AS avg_days_to_decide
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
JOIN spt_certification_entity ce ON ce.certification_id = c.id
JOIN spt_certification_item ci ON ci.certification_entity_id = ce.id
JOIN spt_certification_action ca ON ca.id = ci.action
WHERE ca.decision_date IS NOT NULL
GROUP BY c.manager, cd.name
ORDER BY avg_days_to_decide DESC;
```

---

## 5. Role Analytics

### Role membership counts

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name,
    b.disabled,
    b.requestable,
    ri.assigned_count,
    ri.detected_count,
    ri.entitlement_count
FROM spt_bundle b
LEFT JOIN spt_role_index ri ON b.id = ri.bundle
WHERE b.disabled = 0
ORDER BY ri.detected_count DESC NULLS LAST;
```

**Practical notes**: `spt_role_index` is populated by the Refresh Role Scorecard task. If counts look stale, check when that task last ran.

### Roles detected but not assigned (governance gap)

**Context**: These identities have the entitlements that constitute a role, but the role was never formally granted. This means access accumulated outside the governance process.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    b.name AS detected_role,
    b.type AS role_type
FROM spt_identity_bundles ib
JOIN spt_identity i ON ib.identity_id = i.id
JOIN spt_bundle b ON ib.bundle = b.id
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 0
  AND NOT EXISTS (
      SELECT 1 FROM spt_identity_assigned_roles iar
      WHERE iar.identity_id = i.id AND iar.bundle = b.id
  )
  /* Note: if spt_identity_assigned_roles doesn't exist in your version,
     you'll need to parse spt_identity.attributes XML for RoleAssignment */
ORDER BY b.name, i.name;
```

### Empty roles (defined but no members)

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name,
    owner.name AS owner,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (b.created / 1000 / 86400) AS created_date
FROM spt_bundle b
LEFT JOIN spt_identity owner ON b.owner = owner.id
LEFT JOIN spt_role_index ri ON b.id = ri.bundle
WHERE b.disabled = 0
  AND (ri.detected_count IS NULL OR ri.detected_count = 0)
  AND (ri.assigned_count IS NULL OR ri.assigned_count = 0)
ORDER BY b.created;
```

### Role-to-entitlement mapping

**Context**: What entitlements does each role grant? Uses the profile chain.

```sql
SELECT
    biz.name AS business_role,
    biz.display_name AS business_role_display,
    it.name AS it_role,
    app.name AS application,
    pc.elt AS entitlement_filter
FROM spt_bundle biz
JOIN spt_bundle_requirements br ON biz.id = br.bundle
JOIN spt_bundle it ON br.child = it.id
JOIN spt_profile p ON it.id = p.bundle_id
JOIN spt_application app ON p.application = app.id
JOIN spt_profile_constraints pc ON p.id = pc.profile
WHERE biz.type = 'business' AND biz.disabled = 0
ORDER BY biz.name, it.name, app.name;
```

---

## 6. Compliance and Risk

### Active SOD violations

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    mgr.name AS manager,
    pv.policy_name,
    pv.constraint_name,
    pv.status,
    pv.left_bundles,
    pv.right_bundles,
    pv.mitigator,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pv.created / 1000 / 86400) AS detected_date
FROM spt_policy_violation pv
JOIN spt_identity i ON pv.identity = i.id
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE pv.active = 1
ORDER BY pv.status, pv.created DESC;
```

**Variation — Violation summary by policy:**

```sql
SELECT
    pv.policy_name,
    pv.constraint_name,
    pv.status,
    COUNT(*) AS violation_count
FROM spt_policy_violation pv
WHERE pv.active = 1
GROUP BY pv.policy_name, pv.constraint_name, pv.status
ORDER BY violation_count DESC;
```

### Highest risk identities

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    mgr.name AS manager,
    i.risk_score_weight AS risk_score,
    COUNT(DISTINCT ie.id) AS entitlement_count,
    COUNT(DISTINCT pv.id) AS active_violations
FROM spt_identity i
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
LEFT JOIN spt_identity_entitlement ie ON i.id = ie.identity_id AND ie.aggregation_state = 'Connected'
LEFT JOIN spt_policy_violation pv ON pv.identity = i.id AND pv.active = 1
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 0
GROUP BY i.name, i.display_name, i.extended2, mgr.name, i.risk_score_weight
ORDER BY i.risk_score_weight DESC NULLS LAST
FETCH FIRST 50 ROWS ONLY;
```

### Entitlements without owners

**Context**: Unowned entitlements cannot go through owner-based approval or certification. This is a governance gap.

```sql
SELECT
    app.name AS application,
    ma.attribute,
    ma.value,
    ma.display_name,
    COUNT(ie.id) AS holder_count
FROM spt_managed_attribute ma
JOIN spt_application app ON ma.application = app.id
LEFT JOIN spt_identity_entitlement ie
    ON ie.application = ma.application
    AND ie.value = ma.value
    AND ie.name = ma.attribute
WHERE ma.owner IS NULL
  AND ma.type = 'Entitlement'
GROUP BY app.name, ma.attribute, ma.value, ma.display_name
ORDER BY holder_count DESC;
```

### High-risk entitlements not recently certified

**Context**: Combines risk (from managed attribute metadata) with certification recency to find gaps.

```sql
SELECT
    app.name AS application,
    ma.attribute,
    ma.value AS entitlement_value,
    ma.display_name,
    ma.requestable,
    owner.name AS owner,
    COUNT(DISTINCT ie.identity_id) AS holder_count,
    MAX(TO_DATE('1970-01-01','YYYY-MM-DD') + (ci_action.decision_date / 1000 / 86400)) AS last_certified
FROM spt_managed_attribute ma
JOIN spt_application app ON ma.application = app.id
LEFT JOIN spt_identity owner ON ma.owner = owner.id
LEFT JOIN spt_identity_entitlement ie
    ON ie.application = ma.application
    AND ie.value = ma.value
    AND ie.name = ma.attribute
    AND ie.aggregation_state = 'Connected'
LEFT JOIN spt_certification_item ci
    ON ci.exception_application = app.name
    AND ci.exception_attribute_value = ma.value
LEFT JOIN spt_certification_action ci_action ON ci.action = ci_action.id
WHERE ma.type = 'Entitlement'
  /* filter: add risk criteria based on your extended attributes */
GROUP BY app.name, ma.attribute, ma.value, ma.display_name, ma.requestable, owner.name
HAVING MAX(ci_action.decision_date) IS NULL
    OR MAX(ci_action.decision_date) < (SYSDATE - 180 - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY holder_count DESC;
```

---

## 7. Operational Health

### Last aggregation per application

**Context**: Stale aggregation means stale data. This query identifies applications that haven't been refreshed recently.

```sql
SELECT
    app.name AS application,
    app.type AS connector_type,
    app.authoritative,
    COUNT(l.id) AS account_count,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(l.last_refresh) / 1000 / 86400) AS last_aggregation,
    ROUND(SYSDATE - (TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(l.last_refresh) / 1000 / 86400)), 1) AS days_since_agg
FROM spt_application app
LEFT JOIN spt_link l ON app.id = l.application
GROUP BY app.name, app.type, app.authoritative
ORDER BY last_aggregation ASC NULLS FIRST;
```

**How to read**: `days_since_agg > 2` for a production application likely means something is wrong. Check `spt_task_result` for the aggregation task.

### Stale accounts (no recent aggregation)

```sql
SELECT
    app.name AS application,
    l.native_identity AS account_id,
    i.name AS identity_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (l.last_refresh / 1000 / 86400) AS last_refreshed,
    ROUND(SYSDATE - (TO_DATE('1970-01-01','YYYY-MM-DD') + (l.last_refresh / 1000 / 86400))) AS days_stale
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE l.last_refresh < (SYSDATE - 30 - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  /* 30 days threshold — adjust as needed */
ORDER BY l.last_refresh ASC;
```

### Disconnected entitlements

**Context**: Entitlements that were once seen but are no longer found on the target system. A spike may indicate an aggregation problem.

```sql
SELECT
    app.name AS application,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    COUNT(DISTINCT ie.identity_id) AS affected_identities
FROM spt_identity_entitlement ie
JOIN spt_application app ON ie.application = app.id
WHERE ie.aggregation_state = 'Disconnected'
GROUP BY app.name, ie.name, ie.value
ORDER BY affected_identities DESC;
```

### Request-to-provisioning time

```sql
SELECT
    ir.name AS request_id,
    ir.type AS request_type,
    ir.target_display_name,
    ir.completion_status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS requested,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.end_date / 1000 / 86400) AS completed,
    ROUND((ir.end_date - ir.created) / 1000 / 3600, 1) AS hours_to_complete
FROM spt_identity_request ir
WHERE ir.state = 'Complete'
  AND ir.created > (SYSDATE - 90 - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY hours_to_complete DESC;
```

**Variation — Average turnaround by request type:**

```sql
SELECT
    ir.type AS request_type,
    COUNT(*) AS request_count,
    ROUND(AVG(ir.end_date - ir.created) / 1000 / 3600, 1) AS avg_hours,
    ROUND(MAX(ir.end_date - ir.created) / 1000 / 3600, 1) AS max_hours
FROM spt_identity_request ir
WHERE ir.state = 'Complete' AND ir.end_date IS NOT NULL
  AND ir.created > (SYSDATE - 90 - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
GROUP BY ir.type
ORDER BY avg_hours DESC;
```

### Stuck workflows

**Context**: Workflow cases that haven't completed after an extended period may indicate system issues.

```sql
SELECT
    wc.name AS workflow_name,
    wc.launcher,
    wc.target_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (wc.created / 1000 / 86400) AS started,
    ROUND(SYSDATE - (TO_DATE('1970-01-01','YYYY-MM-DD') + (wc.created / 1000 / 86400))) AS days_running
FROM spt_workflow_case wc
WHERE wc.complete = 0
ORDER BY wc.created ASC;
```

### Open work items aging

```sql
SELECT
    wi.type,
    owner.name AS assigned_to,
    COUNT(*) AS open_count,
    MIN(TO_DATE('1970-01-01','YYYY-MM-DD') + (wi.created / 1000 / 86400)) AS oldest_item,
    ROUND(AVG(SYSDATE - (TO_DATE('1970-01-01','YYYY-MM-DD') + (wi.created / 1000 / 86400))), 1) AS avg_age_days
FROM spt_work_item wi
LEFT JOIN spt_identity owner ON wi.owner = owner.id
WHERE wi.state IS NULL
GROUP BY wi.type, owner.name
ORDER BY avg_age_days DESC;
```

### Table growth monitoring

**Context**: Track the largest tables to anticipate performance and storage issues.

```sql
/* Oracle — for other databases, use their equivalent system views */
SELECT
    table_name,
    num_rows,
    ROUND(num_rows * avg_row_len / 1024 / 1024, 1) AS est_size_mb,
    TO_CHAR(last_analyzed, 'YYYY-MM-DD HH24:MI') AS stats_date
FROM all_tables
WHERE table_name LIKE 'SPT_%'
  AND owner = 'IDENTITYIQ' /* adjust schema owner */
ORDER BY num_rows DESC NULLS LAST;
```

### Task result history

```sql
SELECT
    td.name AS task_name,
    tr.completion_status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (tr.launched / 1000 / 86400) AS started,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (tr.completed / 1000 / 86400) AS finished,
    ROUND((tr.completed - tr.launched) / 1000 / 60, 1) AS duration_minutes
FROM spt_task_result tr
JOIN spt_task_definition td ON tr.definition = td.id
WHERE tr.launched > (SYSDATE - 7 - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY tr.launched DESC;
```

---

## 8. Reusable Views

These `CREATE VIEW` statements encapsulate common joins for repeated use in dashboards and ad-hoc queries.

### v_identity_access — Complete access view

```sql
CREATE OR REPLACE VIEW v_identity_access AS
SELECT
    i.id AS identity_id,
    i.name AS identity_name,
    i.display_name,
    i.firstname,
    i.lastname,
    i.email,
    i.extended1 AS employee_id,
    i.extended2 AS department,
    i.inactive,
    i.risk_score_weight AS risk_score,
    mgr.name AS manager_name,
    mgr.display_name AS manager_display_name,
    app.name AS application_name,
    app.type AS application_type,
    l.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ma.display_name AS entitlement_display_name,
    ie.type AS entitlement_type,
    ie.source AS entitlement_source,
    ie.assigned,
    ie.granted_by_role,
    ie.aggregation_state,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ie.start_date / 1000 / 86400) AS access_start,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ie.end_date / 1000 / 86400) AS access_end
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_link l ON l.identity_id = i.id AND l.application = ie.application
LEFT JOIN spt_managed_attribute ma
    ON ma.application = ie.application
    AND ma.value = ie.value
    AND ma.attribute = ie.name
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1 AND i.is_workgroup = 0;
```

### v_certification_decisions — Flattened certification decisions

```sql
CREATE OR REPLACE VIEW v_certification_decisions AS
SELECT
    cd.name AS campaign_name,
    c.short_name AS cert_name,
    c.manager AS reviewer,
    c.type AS cert_type,
    c.phase,
    ce.target_name AS reviewed_identity,
    ce.target_display_name AS reviewed_display_name,
    ci.type AS item_type,
    ci.exception_application AS application,
    ci.exception_attribute_name AS entitlement_attribute,
    ci.exception_attribute_value AS entitlement_value,
    ci.summary_status AS item_status,
    ca.status AS decision,
    ca.actor_name AS decided_by,
    ca.comments,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.activated / 1000 / 86400) AS cert_start,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.expiration / 1000 / 86400) AS cert_due,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ca.decision_date / 1000 / 86400) AS decision_date
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
JOIN spt_certification_entity ce ON ce.certification_id = c.id
JOIN spt_certification_item ci ON ci.certification_entity_id = ce.id
LEFT JOIN spt_certification_action ca ON ca.id = ci.action;
```

### v_request_history — Flattened request history

```sql
CREATE OR REPLACE VIEW v_request_history AS
SELECT
    ir.name AS request_id,
    ir.type AS request_type,
    ir.state,
    ir.completion_status,
    ir.execution_status,
    ir.requester_display_name AS requester,
    ir.target_display_name AS target,
    ir.external_ticket_id,
    iri.application,
    iri.name AS attribute_name,
    iri.value AS attribute_value,
    iri.operation,
    iri.approval_state,
    iri.provisioning_state,
    iri.approver_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS request_date,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.end_date / 1000 / 86400) AS completion_date,
    ROUND((ir.end_date - ir.created) / 1000 / 3600, 1) AS hours_to_complete
FROM spt_identity_request ir
JOIN spt_identity_request_item iri ON ir.id = iri.identity_request_id;
```

### ETL tips for CLOB extraction

When building reporting pipelines, extract commonly needed CLOB values into flat tables:

```sql
/* Oracle example: Extract IIQDisabled from spt_link attributes */
CREATE TABLE rpt_link_status AS
SELECT
    l.id AS link_id,
    l.identity_id,
    l.application,
    l.native_identity,
    EXTRACTVALUE(
        xmltype(l.attributes),
        '/Attributes/Map/entry[@key="IIQDisabled"]/value/Boolean'
    ) AS iiq_disabled,
    EXTRACTVALUE(
        xmltype(l.attributes),
        '/Attributes/Map/entry[@key="IIQLocked"]/value/Boolean'
    ) AS iiq_locked
FROM spt_link l
WHERE l.attributes IS NOT NULL;
```

```sql
/* Oracle example: Extract role assignments from spt_identity attributes */
/* Warning: This is expensive on large tables — run as a nightly ETL job */
CREATE TABLE rpt_assigned_roles AS
SELECT
    i.id AS identity_id,
    i.name AS identity_name,
    xt.role_name,
    xt.assigner,
    xt.assignment_date
FROM spt_identity i,
     XMLTABLE('/Attributes/Map/entry[@key="RoleAssignments"]/value/List/RoleAssignment'
         PASSING xmltype(i.attributes)
         COLUMNS
             role_name VARCHAR2(256) PATH '@roleName',
             assigner VARCHAR2(256) PATH '@assigner',
             assignment_date VARCHAR2(32) PATH '@date'
     ) xt
WHERE i.attributes LIKE '%RoleAssignment%';
```

**Practical notes**: CLOB extraction queries are **very expensive** on large tables. Never run them against production during business hours. Schedule them as nightly ETL jobs that populate flat reporting tables. Index the reporting tables appropriately for your common query patterns.

### Dashboard-ready aggregations

```sql
/* Identity summary for executive dashboard */
CREATE OR REPLACE VIEW v_identity_summary AS
SELECT
    COUNT(*) AS total_identities,
    SUM(CASE WHEN inactive = 0 THEN 1 ELSE 0 END) AS active,
    SUM(CASE WHEN inactive = 1 THEN 1 ELSE 0 END) AS inactive,
    SUM(CASE WHEN correlated = 0 THEN 1 ELSE 0 END) AS uncorrelated
FROM spt_identity
WHERE is_workgroup = 0;

/* Access request volume by month */
CREATE OR REPLACE VIEW v_request_volume AS
SELECT
    TO_CHAR(TO_DATE('1970-01-01','YYYY-MM-DD') + (created / 1000 / 86400), 'YYYY-MM') AS month,
    type AS request_type,
    completion_status,
    COUNT(*) AS request_count
FROM spt_identity_request
GROUP BY
    TO_CHAR(TO_DATE('1970-01-01','YYYY-MM-DD') + (created / 1000 / 86400), 'YYYY-MM'),
    type,
    completion_status;

/* Violation trend by month */
CREATE OR REPLACE VIEW v_violation_trend AS
SELECT
    TO_CHAR(TO_DATE('1970-01-01','YYYY-MM-DD') + (created / 1000 / 86400), 'YYYY-MM') AS month,
    policy_name,
    status,
    COUNT(*) AS violation_count
FROM spt_policy_violation
GROUP BY
    TO_CHAR(TO_DATE('1970-01-01','YYYY-MM-DD') + (created / 1000 / 86400), 'YYYY-MM'),
    policy_name,
    status;
```

---

## Where to Go Next

- **What do the field values in query results mean?** → [IIQ-Field-Values.md](IIQ-Field-Values.md)
- **How do the business processes work?** → [IIQ-Data-Flows.md](IIQ-Data-Flows.md)
- **What are the concepts behind this data?** → [IIQ-Concepts.md](IIQ-Concepts.md)
- **What are the tables and columns?** → [IIQ.md](IIQ.md)
