DROP TRIGGER IF EXISTS trigger_before_update_users;

DELIMITER $$

CREATE TRIGGER trigger_before_update_users
    BEFORE UPDATE
    ON `users`
    FOR EACH ROW
BEGIN
    IF NEW.name IS NULL OR LENGTH(NEW.name) NOT BETWEEN 1 AND 24 OR
       NEW.surname IS NULL OR LENGTH(NEW.surname) NOT BETWEEN 1 AND 32 OR
       NEW.phone IS NULL OR LENGTH(NEW.phone) < 6 OR
       NEW.password IS NULL OR LENGTH(NEW.password) < 6 THEN
        SET NEW.name = OLD.name;
        SET NEW.surname = OLD.surname;
        SET NEW.phone = OLD.phone;
        SET NEW.password = OLD.password;
    END IF;
END;

DELIMITER ;
