WITH cte_memberof AS (
    SELECT
        link.id             AS link_id,
        link.identity_id,
        link.native_identity,
        link.display_name,
        jt.group_name
    FROM spt_link link
    JOIN JSON_TABLE(
        CASE
            WHEN link.attributes IS NULL                        THEN '[]'
            WHEN link.attributes NOT LIKE '%memberOf%'          THEN '[]'
            ELSE CONCAT(
                '["',
                REPLACE(
                    REPLACE(
                        TRIM(TRAILING ',' FROM
                            REPLACE(
                                EXTRACTVALUE(
                                    REGEXP_REPLACE(
                                        REPLACE(link.attributes, ',', '$'),
                                        '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                                        '<String>"$1"</String>'
                                    ),
                                    '//entry[@key="memberOf"]/value/List/String'
                                ),
                                '"', "','"
                            )
                        ),
                        '"', '\\"'
                    ),
                    ',', '","'
                ),
                '"]'
            )
        END,
        '$[*]' COLUMNS (group_name VARCHAR(255) PATH '$')
    ) jt
    WHERE link.attributes IS NOT NULL
      AND link.attributes LIKE '%memberOf%'
      AND jt.group_name IS NOT NULL
      AND TRIM(jt.group_name) != ''
),

cte_constraints AS (
    SELECT
        pcon.id         AS constraint_id,
        pcon.profile    AS profile_id,
        TRIM(REPLACE(
            SUBSTRING_INDEX(SUBSTRING_INDEX(pcon.elt, '({', -1), '})', 1),
            '$', ','
        ))              AS group_name
    FROM spt_profile_constraints pcon
    WHERE pcon.elt IS NOT NULL
      AND pcon.elt LIKE '%({%'
      AND pcon.elt LIKE '%})%'
)

SELECT DISTINCT
    cm.native_identity,
    cm.display_name,
    cm.group_name       AS entitlement,
    sb.name             AS it_role
FROM cte_memberof           cm
JOIN cte_constraints        cc   ON cc.group_name  = cm.group_name
JOIN spt_profile            prof ON prof.id         = cc.profile_id
JOIN spt_bundle_requirements br  ON br.child        = prof.bundle_id
JOIN spt_bundle             sb   ON sb.id           = br.child
WHERE sb.type = 'IT'
ORDER BY cm.display_name, sb.name;