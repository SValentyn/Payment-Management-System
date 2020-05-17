DROP TRIGGER IF EXISTS `trigger_before_insert_in_letters`;

DELIMITER $$

CREATE TRIGGER `trigger_before_insert_in_letters`
    BEFORE INSERT
    ON `letters`
    FOR EACH ROW
BEGIN
    IF NEW.user_id IS NULL OR NEW.user_id NOT IN (SELECT user_id FROM users) OR
       NEW.typeQuestion IS NULL OR
       NEW.date IS NULL OR NEW.date > NOW() THEN
        SET NEW.typeQuestion = '';
        SET NEW.description = '';
        SET NEW.date = CURRENT_TIMESTAMP();
        SET NEW.is_processed = 1;
    END IF;
END;

DELIMITER ;
