DROP TRIGGER IF EXISTS `trigger_before_insert_in_users`;

DELIMITER $$

CREATE TRIGGER `trigger_before_insert_in_users`
    BEFORE INSERT
    ON `users`
    FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR LENGTH(NEW.name) NOT BETWEEN 1 AND 255 OR
       NEW.surname IS NULL OR LENGTH(NEW.surname) NOT BETWEEN 1 AND 255 OR
       NEW.phone IS NULL OR LENGTH(NEW.phone) NOT BETWEEN 6 AND 18 OR
       LENGTH(NEW.email) > 255 OR
       NEW.password IS NULL OR LENGTH(NEW.password) NOT BETWEEN 6 AND 255 THEN
        SET NEW.name = '';
        SET NEW.surname = '';
        SET NEW.phone = '';
        SET NEW.email = '';
        SET NEW.password = '';
    END IF;
END;

DELIMITER ;
