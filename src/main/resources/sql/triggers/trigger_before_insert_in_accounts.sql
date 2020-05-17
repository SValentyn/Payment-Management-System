DROP TRIGGER IF EXISTS `trigger_before_insert_in_accounts`;

DELIMITER $$

CREATE TRIGGER `trigger_before_insert_in_accounts`
    BEFORE INSERT
    ON `accounts`
    FOR EACH ROW
BEGIN
    IF NEW.user_id IS NULL OR NEW.user_id NOT IN (SELECT user_id FROM users) OR
       NEW.number IS NULL OR LENGTH(NEW.number) <> 20 OR
       NEW.currency IS NULL OR LENGTH(NEW.currency) <> 3 OR
       NEW.balance IS NULL OR NEW.balance < 0.0 THEN
        SET NEW.number = '';
        SET NEW.currency = '';
        SET NEW.balance = 0;
        SET NEW.is_blocked = 1;
        SET NEW.is_deleted = 1;
    END IF;
END;

DELIMITER ;
