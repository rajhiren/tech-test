/*
 Tech test for skills test.

 Notes
 * From MySQL 5.6.5 any DATETIME or TIMESTAMP column can be initialised or updated
   to the current timestamp. See http://dev.mysql.com/doc/refman/5.6/en/timestamp-initialization.html.
   In the meantime create_time is populated by a trigger, but must either have a default value or
   allow NULLs for this to happen.
*/

USE test;

DROP TABLE IF EXISTS Test;

CREATE TABLE Test (
    agent_id                            INT UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique ID',
    brand_id                            VARCHAR(10)     NOT NULL COMMENT 'Brand ID',
    group_id                            VARCHAR(30)     NOT NULL COMMENT 'Group ID',
    agent_username                      VARCHAR(50)     NOT NULL COMMENT 'name',
    agent_email 						            VARCHAR(30)     NOT NULL COMMENT 'Email',
    create_time                         DATETIME        NOT NULL DEFAULT '0000-00-00' COMMENT 'Time this row was created - set to NOW() by an insert trigger',
    create_system                       VARCHAR(30)     NOT NULL COMMENT 'System in which this row was created',
    create_version                      VARCHAR(12)     NULL COMMENT 'System version',
    create_source                       VARCHAR(255)    NOT NULL COMMENT 'Source of this row, eg user name, file name, URL',
    last_update                         TIMESTAMP       NOT NULL COMMENT 'Time this row was last updated',
    update_system                       VARCHAR(30)     NULL COMMENT 'System in which this row was last updated',
    update_version                      VARCHAR(12)     NULL COMMENT 'System version',
    update_source                       VARCHAR(255)    NULL COMMENT 'Source of the latest change, eg user name, file name, URL',
    UNIQUE KEY idx_test_1 ( agent_id, brand_id, group_id )
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
 Default create_time to NOW()
 */

DROP TRIGGER IF EXISTS test_before_insert;

delimiter $$
CREATE TRIGGER test_before_insert BEFORE INSERT ON forecasts
  FOR EACH ROW BEGIN
    SET NEW.create_time = NOW();
  END;
$$

DELIMITER ;
