DROP TRIGGER IF EXISTS `trigger_before_insert_in_bank_cards`;

DELIMITER $$

CREATE TRIGGER `trigger_before_insert_in_bank_cards`
    BEFORE INSERT
    ON `bank_cards`
    FOR EACH ROW
BEGIN
    IF NEW.account_id IS NULL OR NEW.account_id NOT IN (SELECT account_id FROM accounts) OR
       NEW.number IS NULL OR LENGTH(NEW.number) <> 16 OR
       NEW.cvv IS NULL OR LENGTH(NEW.cvv) <> 3 OR
       NEW.validity IS NULL THEN
        SET NEW.number = '';
        SET NEW.cvv = '';
        SET NEW.validity = DATE_FORMAT(NOW(), '%m/%Y');
        SET NEW.is_active = 0;
    END IF;
END;

DELIMITER ;
