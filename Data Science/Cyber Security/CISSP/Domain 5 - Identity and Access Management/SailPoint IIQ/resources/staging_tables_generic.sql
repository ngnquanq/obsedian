-- =============================================================================
-- SAILPOINT IIQ: IAM ROLE REPORTING STAGING TABLES
-- Purpose : Normalize spt_link.attributes and spt_profile_constraints.elt
--           to enable fast indexed joins for role reporting
-- DB Ver  : MySQL 8.0.39
-- Schema  : Replace <your_schema> with your target schema name
-- =============================================================================


-- =============================================================================
-- SECTION 1: EVALUATION SELECT STATEMENTS
-- Run these BEFORE creating anything to validate data quality
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1A. Evaluate spt_link memberOf source data
--     Edge cases handled:
--       - NULL attributes
--       - attributes with no memberOf key
--       - memberOf with empty list
--       - memberOf with special characters (quotes, backslashes)
--       - memberOf values that are empty strings after trimming
--       - JSON construction failure (falls back to '[]')
-- -----------------------------------------------------------------------------
SELECT
  link.id                                           AS link_id,
  link.display_name,
  'memberOf'                                        AS attr_key,
  jt.attr_value,

  -- Edge case flags for evaluation
  CASE
    WHEN link.attributes IS NULL
      THEN 'NULL_ATTRIBUTES'
    WHEN link.attributes NOT LIKE '%memberOf%'
      THEN 'NO_MEMBEROF_KEY'
    WHEN TRIM(TRAILING ',' FROM
           REPLACE(
             EXTRACTVALUE(
               REGEXP_REPLACE(
                 REPLACE(link.attributes, ',', '$'),
                 '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                 '<String>"$1"</String>'
               ),
               '//entry[@key="memberOf"]/value/List/String'
             ),
             '"', "','", "'"
           )
         ) = ''
      THEN 'EMPTY_MEMBEROF_LIST'
    WHEN jt.attr_value IS NULL
      THEN 'NULL_AFTER_SPLIT'
    WHEN TRIM(jt.attr_value) = ''
      THEN 'EMPTY_STRING_AFTER_SPLIT'
    ELSE 'OK'
  END                                               AS data_quality_flag

FROM spt_link link
JOIN JSON_TABLE(
  CASE
    WHEN link.attributes IS NULL
      THEN '[]'
    WHEN link.attributes NOT LIKE '%memberOf%'
      THEN '[]'
    WHEN TRIM(TRAILING ',' FROM
           REPLACE(
             EXTRACTVALUE(
               REGEXP_REPLACE(
                 REPLACE(link.attributes, ',', '$'),
                 '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                 '<String>"$1"</String>'
               ),
               '//entry[@key="memberOf"]/value/List/String'
             ),
             '"', "','", "'"
           )
         ) = ''
      THEN '[]'
    ELSE
      CONCAT(
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
                '"', "','", "'"
              )
            ),
            '"', '\\"'
          ),
          ',', '","'
        ),
        '"]'
      )
  END,
  '$[*]' COLUMNS (attr_value VARCHAR(255) PATH '$')
) jt

WHERE link.attributes IS NOT NULL
  AND link.attributes LIKE '%memberOf%'
  AND jt.attr_value IS NOT NULL
  AND TRIM(jt.attr_value) != ''

ORDER BY link.id
LIMIT 1000;   -- evaluate first 1000 rows, remove LIMIT for full run


-- -----------------------------------------------------------------------------
-- 1B. Data quality summary for spt_link
-- -----------------------------------------------------------------------------
SELECT
  CASE
    WHEN attributes IS NULL
      THEN 'NULL_ATTRIBUTES'
    WHEN attributes NOT LIKE '%memberOf%'
      THEN 'NO_MEMBEROF_KEY'
    WHEN TRIM(TRAILING ',' FROM
           REPLACE(
             EXTRACTVALUE(
               REGEXP_REPLACE(
                 REPLACE(attributes, ',', '$'),
                 '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                 '<String>"$1"</String>'
               ),
               '//entry[@key="memberOf"]/value/List/String'
             ),
             '"', "','", "'"
           )
         ) = ''
      THEN 'EMPTY_MEMBEROF_LIST'
    ELSE 'HAS_MEMBEROF'
  END                         AS status,
  COUNT(*)                    AS row_count
FROM spt_link
GROUP BY 1
ORDER BY 2 DESC;


-- -----------------------------------------------------------------------------
-- 1C. Evaluate spt_profile_constraints elt source data
--     Edge cases handled:
--       - NULL elt
--       - elt missing ({ or }) wrapper
--       - elt with empty group name after extraction
--       - elt with $ characters (artifact from comma replacement)
-- -----------------------------------------------------------------------------
SELECT
  pcon.id                                           AS constraint_id,
  pcon.profile                                      AS profile_id,
  pcon.elt                                          AS raw_elt,

  CASE
    WHEN pcon.elt IS NULL
      THEN NULL
    WHEN pcon.elt NOT LIKE '%({%'
      THEN NULL
    WHEN pcon.elt NOT LIKE '%})%'
      THEN NULL
    ELSE
      TRIM(
        REPLACE(
          SUBSTRING_INDEX(
            SUBSTRING_INDEX(pcon.elt, '({', -1),
            '})', 1
          ),
          '$', ','
        )
      )
  END                                               AS group_name,

  CASE
    WHEN pcon.elt IS NULL
      THEN 'NULL_ELT'
    WHEN pcon.elt NOT LIKE '%({%'
      THEN 'MISSING_OPEN_WRAPPER'
    WHEN pcon.elt NOT LIKE '%})%'
      THEN 'MISSING_CLOSE_WRAPPER'
    WHEN TRIM(
           REPLACE(
             SUBSTRING_INDEX(
               SUBSTRING_INDEX(pcon.elt, '({', -1), '})', 1
             ), '$', ','
           )
         ) = ''
      THEN 'EMPTY_GROUP_NAME'
    ELSE 'OK'
  END                                               AS data_quality_flag

FROM spt_profile_constraints pcon
ORDER BY pcon.id
LIMIT 1000;


-- -----------------------------------------------------------------------------
-- 1D. Data quality summary for spt_profile_constraints
-- -----------------------------------------------------------------------------
SELECT
  CASE
    WHEN elt IS NULL              THEN 'NULL_ELT'
    WHEN elt NOT LIKE '%({%'      THEN 'MISSING_OPEN_WRAPPER'
    WHEN elt NOT LIKE '%})%'      THEN 'MISSING_CLOSE_WRAPPER'
    WHEN TRIM(REPLACE(
           SUBSTRING_INDEX(SUBSTRING_INDEX(elt,'({',-1),'})',1),
           '$',','
         )) = ''                  THEN 'EMPTY_GROUP_NAME'
    ELSE                               'OK'
  END                             AS status,
  COUNT(*)                        AS row_count
FROM spt_profile_constraints
GROUP BY 1
ORDER BY 2 DESC;


-- =============================================================================
-- SECTION 2: TABLE CREATION WITH INDEXES
-- Replace <your_schema> with your actual schema name before running
-- =============================================================================

DROP TABLE IF EXISTS <your_schema>.stg_link_memberof;

CREATE TABLE <your_schema>.stg_link_memberof (
  id              BIGINT          NOT NULL AUTO_INCREMENT  COMMENT 'Surrogate PK',
  link_id         VARCHAR(255)    NOT NULL                 COMMENT 'FK to spt_link.id',
  display_name    VARCHAR(255)                             COMMENT 'Account display name',
  group_name      VARCHAR(255)    NOT NULL                 COMMENT 'Extracted memberOf value',
  created_at      DATETIME        NOT NULL
                  DEFAULT CURRENT_TIMESTAMP               COMMENT 'Refresh timestamp',

  PRIMARY KEY (id),

  -- Supports JOIN back to spt_link
  INDEX idx_link_id       (link_id),

  -- Supports equality join ON group_name = group_name
  INDEX idx_group_name    (group_name),

  -- Composite: covers full join path in one index scan
  INDEX idx_composite     (group_name, link_id)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Normalized memberOf values from spt_link.attributes. Refreshed nightly.';


DROP TABLE IF EXISTS <your_schema>.stg_profile_constraints;

CREATE TABLE <your_schema>.stg_profile_constraints (
  id              BIGINT          NOT NULL AUTO_INCREMENT  COMMENT 'Surrogate PK',
  constraint_id   VARCHAR(255)    NOT NULL                 COMMENT 'FK to spt_profile_constraints.id',
  profile_id      VARCHAR(255)    NOT NULL                 COMMENT 'FK to spt_profile.id',
  group_name      VARCHAR(255)    NOT NULL                 COMMENT 'Extracted group name from elt',
  created_at      DATETIME        NOT NULL
                  DEFAULT CURRENT_TIMESTAMP               COMMENT 'Refresh timestamp',

  PRIMARY KEY (id),

  -- Supports equality join ON group_name = group_name
  INDEX idx_group_name    (group_name),

  -- Supports JOIN to spt_profile
  INDEX idx_profile_id    (profile_id),

  -- Composite: covers full join path in one index scan
  INDEX idx_composite     (group_name, profile_id)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Normalized group constraints from spt_profile_constraints.elt. Refreshed nightly.';


-- =============================================================================
-- SECTION 3: POPULATION INSERT STATEMENTS
-- =============================================================================

TRUNCATE TABLE <your_schema>.stg_link_memberof;

INSERT INTO <your_schema>.stg_link_memberof
  (link_id, display_name, group_name, created_at)
SELECT
  link.id,
  link.display_name,
  jt.attr_value,
  NOW()
FROM spt_link link
JOIN JSON_TABLE(
  CASE
    WHEN link.attributes IS NULL
      THEN '[]'
    WHEN link.attributes NOT LIKE '%memberOf%'
      THEN '[]'
    WHEN TRIM(TRAILING ',' FROM
           REPLACE(
             EXTRACTVALUE(
               REGEXP_REPLACE(
                 REPLACE(link.attributes, ',', '$'),
                 '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                 '<String>"$1"</String>'
               ),
               '//entry[@key="memberOf"]/value/List/String'
             ),
             '"', "','", "'"
           )
         ) = ''
      THEN '[]'
    ELSE
      CONCAT(
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
                '"', "','", "'"
              )
            ),
            '"', '\\"'
          ),
          ',', '","'
        ),
        '"]'
      )
  END,
  '$[*]' COLUMNS (attr_value VARCHAR(255) PATH '$')
) jt
WHERE link.attributes IS NOT NULL
  AND link.attributes LIKE '%memberOf%'
  AND jt.attr_value IS NOT NULL
  AND TRIM(jt.attr_value) != '';


TRUNCATE TABLE <your_schema>.stg_profile_constraints;

INSERT INTO <your_schema>.stg_profile_constraints
  (constraint_id, profile_id, group_name, created_at)
SELECT
  pcon.id,
  pcon.profile,
  TRIM(
    REPLACE(
      SUBSTRING_INDEX(
        SUBSTRING_INDEX(pcon.elt, '({', -1),
        '})', 1
      ),
      '$', ','
    )
  ),
  NOW()
FROM spt_profile_constraints pcon
WHERE pcon.elt IS NOT NULL
  AND pcon.elt LIKE '%({%'
  AND pcon.elt LIKE '%})%'
  AND TRIM(
        REPLACE(
          SUBSTRING_INDEX(
            SUBSTRING_INDEX(pcon.elt, '({', -1), '})', 1
          ),
          '$', ','
        )
      ) != '';


-- =============================================================================
-- SECTION 4: STORED PROCEDURE (MySQL 8.0.39)
-- Replace <your_schema> with your actual schema name before running
-- =============================================================================

DROP PROCEDURE IF EXISTS <your_schema>.sp_refresh_iam_staging;

DELIMITER //

CREATE PROCEDURE <your_schema>.sp_refresh_iam_staging()
  COMMENT 'Refreshes stg_link_memberof and stg_profile_constraints. MySQL 8.0.39.'
BEGIN

  -- -------------------------------------------------------------------------
  -- Variable declarations
  -- -------------------------------------------------------------------------
  DECLARE v_start_time          DATETIME      DEFAULT NOW();
  DECLARE v_link_rows           INT           DEFAULT 0;
  DECLARE v_pcon_rows           INT           DEFAULT 0;
  DECLARE v_prev_link_rows      INT           DEFAULT 0;
  DECLARE v_prev_pcon_rows      INT           DEFAULT 0;
  DECLARE v_drop_pct_link       DECIMAL(5,2)  DEFAULT 0;
  DECLARE v_drop_pct_pcon       DECIMAL(5,2)  DEFAULT 0;
  DECLARE v_error_message       VARCHAR(500);
  DECLARE v_sqlstate            VARCHAR(5);
  DECLARE v_errno               INT;

  -- -------------------------------------------------------------------------
  -- Error handler
  -- -------------------------------------------------------------------------
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1
      v_sqlstate      = RETURNED_SQLSTATE,
      v_errno         = MYSQL_ERRNO,
      v_error_message = MESSAGE_TEXT;

    INSERT INTO <your_schema>.stg_refresh_log
      (procedure_name, status, message, started_at, completed_at)
    VALUES (
      'sp_refresh_iam_staging',
      'ERROR',
      CONCAT(
        'SQLSTATE: ', v_sqlstate,
        ' | ERRNO: ',  v_errno,
        ' | MSG: ',    v_error_message
      ),
      v_start_time,
      NOW()
    );

    RESIGNAL;
  END;


  -- -------------------------------------------------------------------------
  -- Create log table if it does not exist
  -- -------------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS <your_schema>.stg_refresh_log (
    id              BIGINT        NOT NULL AUTO_INCREMENT,
    procedure_name  VARCHAR(100),
    status          VARCHAR(20),
    message         TEXT,
    link_rows       INT,
    pcon_rows       INT,
    started_at      DATETIME,
    completed_at    DATETIME,
    PRIMARY KEY (id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


  -- -------------------------------------------------------------------------
  -- Capture previous row counts for anomaly detection
  -- -------------------------------------------------------------------------
  SELECT COUNT(*) INTO v_prev_link_rows
  FROM <your_schema>.stg_link_memberof;

  SELECT COUNT(*) INTO v_prev_pcon_rows
  FROM <your_schema>.stg_profile_constraints;


  -- -------------------------------------------------------------------------
  -- Step 1: Refresh stg_link_memberof
  -- -------------------------------------------------------------------------
  TRUNCATE TABLE <your_schema>.stg_link_memberof;

  INSERT INTO <your_schema>.stg_link_memberof
    (link_id, display_name, group_name, created_at)
  SELECT
    link.id,
    link.display_name,
    jt.attr_value,
    NOW()
  FROM spt_link link
  JOIN JSON_TABLE(
    CASE
      WHEN link.attributes IS NULL
        THEN '[]'
      WHEN link.attributes NOT LIKE '%memberOf%'
        THEN '[]'
      WHEN TRIM(TRAILING ',' FROM
             REPLACE(
               EXTRACTVALUE(
                 REGEXP_REPLACE(
                   REPLACE(link.attributes, ',', '$'),
                   '<String>([0-9a-zA-Z!@#$%^&*-_+=(),. \']*)</String>',
                   '<String>"$1"</String>'
                 ),
                 '//entry[@key="memberOf"]/value/List/String'
               ),
               '"', "','", "'"
             )
           ) = ''
        THEN '[]'
      ELSE
        CONCAT(
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
                  '"', "','", "'"
                )
              ),
              '"', '\\"'
            ),
            ',', '","'
          ),
          '"]'
        )
    END,
    '$[*]' COLUMNS (attr_value VARCHAR(255) PATH '$')
  ) jt
  WHERE link.attributes IS NOT NULL
    AND link.attributes LIKE '%memberOf%'
    AND jt.attr_value IS NOT NULL
    AND TRIM(jt.attr_value) != '';

  SELECT ROW_COUNT() INTO v_link_rows;


  -- -------------------------------------------------------------------------
  -- Step 2: Refresh stg_profile_constraints
  -- -------------------------------------------------------------------------
  TRUNCATE TABLE <your_schema>.stg_profile_constraints;

  INSERT INTO <your_schema>.stg_profile_constraints
    (constraint_id, profile_id, group_name, created_at)
  SELECT
    pcon.id,
    pcon.profile,
    TRIM(
      REPLACE(
        SUBSTRING_INDEX(
          SUBSTRING_INDEX(pcon.elt, '({', -1),
          '})', 1
        ),
        '$', ','
      )
    ),
    NOW()
  FROM spt_profile_constraints pcon
  WHERE pcon.elt IS NOT NULL
    AND pcon.elt LIKE '%({%'
    AND pcon.elt LIKE '%})%'
    AND TRIM(
          REPLACE(
            SUBSTRING_INDEX(
              SUBSTRING_INDEX(pcon.elt, '({', -1), '})', 1
            ),
            '$', ','
          )
        ) != '';

  SELECT ROW_COUNT() INTO v_pcon_rows;


  -- -------------------------------------------------------------------------
  -- Step 3: Anomaly detection
  --         Warn if either table drops more than 20% vs previous run
  -- -------------------------------------------------------------------------
  IF v_prev_link_rows > 0 THEN
    SET v_drop_pct_link = ((v_prev_link_rows - v_link_rows) / v_prev_link_rows) * 100;
  END IF;

  IF v_prev_pcon_rows > 0 THEN
    SET v_drop_pct_pcon = ((v_prev_pcon_rows - v_pcon_rows) / v_prev_pcon_rows) * 100;
  END IF;

  IF v_drop_pct_link > 20 OR v_drop_pct_pcon > 20 THEN

    INSERT INTO <your_schema>.stg_refresh_log
      (procedure_name, status, message, link_rows, pcon_rows, started_at, completed_at)
    VALUES (
      'sp_refresh_iam_staging',
      'WARNING',
      CONCAT(
        'Row count dropped significantly. ',
        'stg_link_memberof: ',        v_prev_link_rows, ' → ', v_link_rows,
        ' (', ROUND(v_drop_pct_link, 1), '% drop). ',
        'stg_profile_constraints: ',  v_prev_pcon_rows, ' → ', v_pcon_rows,
        ' (', ROUND(v_drop_pct_pcon, 1), '% drop).'
      ),
      v_link_rows,
      v_pcon_rows,
      v_start_time,
      NOW()
    );

  ELSE

    INSERT INTO <your_schema>.stg_refresh_log
      (procedure_name, status, message, link_rows, pcon_rows, started_at, completed_at)
    VALUES (
      'sp_refresh_iam_staging',
      'SUCCESS',
      CONCAT(
        'Refresh completed. ',
        'stg_link_memberof: ',       v_link_rows, ' rows. ',
        'stg_profile_constraints: ', v_pcon_rows, ' rows.'
      ),
      v_link_rows,
      v_pcon_rows,
      v_start_time,
      NOW()
    );

  END IF;


  -- -------------------------------------------------------------------------
  -- Step 4: Return summary to caller
  -- -------------------------------------------------------------------------
  SELECT
    'sp_refresh_iam_staging'                        AS procedure_name,
    v_link_rows                                     AS stg_link_memberof_rows,
    v_pcon_rows                                     AS stg_profile_constraints_rows,
    v_start_time                                    AS started_at,
    NOW()                                           AS completed_at,
    TIMESTAMPDIFF(SECOND, v_start_time, NOW())      AS duration_seconds;

END //

DELIMITER ;


-- =============================================================================
-- SECTION 5: FINAL REPORTING QUERY
-- =============================================================================
SELECT DISTINCT
  lm.link_id,
  lm.display_name,
  it.name             AS it_role
FROM <your_schema>.stg_link_memberof              lm
JOIN <your_schema>.stg_profile_constraints        pc
  ON  pc.group_name       = lm.group_name
JOIN spt_profile                                  prof
  ON  prof.id             = pc.profile_id
JOIN spt_bundle_requirements                      br
  ON  br.child            = prof.bundle_id
JOIN spt_bundle                                   it
  ON  it.id               = br.child
ORDER BY lm.display_name, it.name;


-- =============================================================================
-- SECTION 6: MONITORING QUERIES
-- =============================================================================

-- Latest refresh log
SELECT *
FROM <your_schema>.stg_refresh_log
ORDER BY id DESC
LIMIT 10;

-- Row count sanity check
SELECT
  'stg_link_memberof'             AS table_name,
  COUNT(*)                        AS total_rows,
  COUNT(DISTINCT link_id)         AS distinct_links,
  COUNT(DISTINCT group_name)      AS distinct_groups,
  MAX(created_at)                 AS last_refreshed
FROM <your_schema>.stg_link_memberof

UNION ALL

SELECT
  'stg_profile_constraints',
  COUNT(*),
  COUNT(DISTINCT profile_id),
  COUNT(DISTINCT group_name),
  MAX(created_at)
FROM <your_schema>.stg_profile_constraints;

-- Manual call for testing or ad-hoc refresh
-- CALL <your_schema>.sp_refresh_iam_staging();
