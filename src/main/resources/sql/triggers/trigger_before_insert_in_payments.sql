DROP TRIGGER IF EXISTS `trigger_before_insert_in_payments`;

DELIMITER $$

CREATE TRIGGER `trigger_before_insert_in_payments`
    BEFORE INSERT
    ON `payments`
    FOR EACH ROW
BEGIN
    IF NEW.account_id IS NULL OR NEW.account_id NOT IN (SELECT account_id FROM accounts) OR
       NEW.senderNumber IS NULL OR LENGTH(NEW.senderNumber) <> 20 OR
       NEW.senderAmount IS NULL OR NEW.senderAmount < 0.0 OR
       NEW.senderCurrency IS NULL OR LENGTH(NEW.senderCurrency) <> 3 OR
       NEW.recipientNumber IS NULL OR LENGTH(NEW.recipientNumber) < 16 OR
       NEW.exchangeRate IS NULL OR NEW.exchangeRate < 0.0 OR
       NEW.newBalance IS NULL OR NEW.newBalance < 0.0 OR
       NEW.date IS NULL OR NEW.date > NOW() THEN
        SET NEW.is_outgoing = 1;
        SET NEW.senderNumber = '';
        SET NEW.senderAmount = 0.0;
        SET NEW.senderCurrency = '';
        SET NEW.recipientNumber = '';
        SET NEW.senderAmount = 0.0;
        SET NEW.senderCurrency = '';
        SET NEW.exchangeRate = 0.0;
        SET NEW.date = CURRENT_TIMESTAMP();
        SET NEW.`condition` = 0;
    END IF;
END;

DELIMITER ;
