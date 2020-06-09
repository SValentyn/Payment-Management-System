# Database for site: `ha9pcps6k1m1y674`

DROP DATABASE IF EXISTS `pms_db`;

CREATE DATABASE `pms_db`
    CHARACTER SET utf8
    COLLATE 'utf8_general_ci';

USE `pms_db`;

SET NAMES utf8;
SET CHARSET utf8;
SET CHARACTER SET utf8;

SET auto_increment_increment = 1;
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET character_set_server = utf8;

DROP TABLE IF EXISTS `action_log`;

DROP TABLE IF EXISTS `letters`;

DROP TABLE IF EXISTS `payments`;

DROP TABLE IF EXISTS `bank_cards`;

DROP TABLE IF EXISTS `accounts`;

DROP TABLE IF EXISTS `roles`;

DROP TABLE IF EXISTS `users`;

-- -- --
CREATE TABLE `users`
(
    `user_id`           INT(11)      NOT NULL AUTO_INCREMENT,
    `name`              TEXT         NOT NULL,
    `surname`           TEXT         NOT NULL,
    `phone`             VARCHAR(255) NOT NULL,
    `email`             VARCHAR(255),
    `password`          VARCHAR(255) NOT NULL,
    `registration_date` VARCHAR(255) NOT NULL,
    `role_id`           INT(11)      NOT NULL,
    PRIMARY KEY (`user_id`)
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO `users` (`user_id`, `name`, `surname`, `phone`, `email`, `password`, `registration_date`, `role_id`)
VALUES
# admin (pass: 111111)
(1, 'Cristoforo', 'Colombo', '+393524594551',
 'Cristoforo-Colombo@gmail.com', '96e79218965eb72c92a549dd5a330112', '26/10/2019', 2),
# user (pass: 000000)
(2, 'Fernando', 'de Magallanes', '+34645364524',
 'Fernando-de-Magallanes@outlook.com', '670b14728ad9902aecba32e22fa4f6bd', '16/11/2019', 1),
# user (pass: 000001)
(3, 'James', 'Cook', '+447465106475',
 'James-Cook@gmail.com', '04fc711301f3c784d66955d98d399afb', '02/01/2020', 1),
# user (pass: 000002)
(4, 'Vasco', 'da Gama', '+351919131006',
 'Vasco-da-Gama@gmail.com', '768c1c687efe184ae6dd2420710b8799', '13/02/2020', 1);
-- -- --

-- -- --
CREATE TABLE `roles`
(
    `role_id`    INT(11)      NOT NULL AUTO_INCREMENT,
    `role_title` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`role_id`)
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO `roles` (`role_id`, `role_title`)
VALUES (1, 'user'),
       (2, 'admin');
-- -- --

-- -- --
CREATE TABLE `accounts`
(
    `account_id` INT(11)      NOT NULL AUTO_INCREMENT,
    `user_id`    INT(11)      NOT NULL,
    `number`     VARCHAR(255) NOT NULL,
    `balance`    DOUBLE       NOT NULL,
    `currency`   VARCHAR(3)   NOT NULL,
    `is_blocked` BOOLEAN      NOT NULL DEFAULT TRUE,
    `is_deleted` BOOLEAN      NOT NULL DEFAULT TRUE,
    PRIMARY KEY (`account_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO `accounts` (`account_id`, `user_id`, `number`, `balance`, `currency`, `is_blocked`, `is_deleted`)
VALUES (1, 2, '00000000000000000000', 9500.00, 'MXN', false, false),
       (2, 2, '11111000000000000000', 7805.00, 'UAH', false, false),
       (3, 2, '11111222220000000000', 3030.00, 'PLN', false, false),
       (4, 3, '00000000000000000001', 10020.00, 'YER', true, false),
       (5, 3, '11111000000000000001', 990.00, 'AUD', false, false),
       (6, 4, '00000000000000000002', 1115.00, 'MKD', false, false);
-- -- --

-- -- --
CREATE TABLE `bank_cards`
(
    `card_id`    INT(11)      NOT NULL AUTO_INCREMENT,
    `account_id` INT(11)      NOT NULL,
    `number`     VARCHAR(255) NOT NULL,
    `cvv`        VARCHAR(3)   NOT NULL,
    `validity`   VARCHAR(255) NOT NULL,
    `is_active`  BOOLEAN      NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`card_id`),
    FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO `bank_cards` (`card_id`, `account_id`, `number`, `cvv`, `validity`, `is_active`)
VALUES (1, 1, '0000000000000000', '200', '03/2021', true),
       (2, 1, '0000007777000000', '717', '11/2021', true),
       (3, 2, '0000008888000000', '809', '09/2020', false),
       (4, 2, '0000009999000000', '191', '01/2022', true),
       (5, 3, '0000006666000000', '500', '05/2021', true),
       (6, 4, '4444000000000000', '404', '10/2020', true);
-- -- --

-- -- --
CREATE TABLE `payments`
(
    `payment_id`        INT(11)      NOT NULL AUTO_INCREMENT,
    `account_id`        INT(11)      NOT NULL,
    `is_outgoing`       BOOLEAN      NOT NULL,
    `senderNumber`      VARCHAR(255) NOT NULL,
    `senderAmount`      DOUBLE       NOT NULL,
    `senderCurrency`    VARCHAR(3)   NOT NULL,
    `recipientNumber`   VARCHAR(255) NOT NULL,
    `recipientAmount`   DOUBLE,
    `recipientCurrency` VARCHAR(3),
    `exchangeRate`      DOUBLE       NOT NULL,
    `newBalance`        DOUBLE       NOT NULL,
    `appointment`       TEXT,
    `date`              DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `condition`         BOOLEAN      NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO `payments` (`account_id`, `is_outgoing`, `senderNumber`, `senderAmount`, `senderCurrency`,
                        `recipientNumber`, `recipientAmount`, `recipientCurrency`,
                        `exchangeRate`, `newBalance`, `appointment`, `date`, `condition`)
VALUES (1, 1, '00000000000000000000', 20.0, 'MXN', '11111000000000000000',
        20.0, 'UAH', 1.0, 9480.0, '', '2020-03-25 00:43:00', 1),
       (2, 0, '00000000000000000000', 20.0, 'MXN', '11111000000000000000',
        20.0, 'UAH', 1.0, 7825.0, '', '2020-03-25 00:43:00', 1),
       (3, 1, '11111222220000000000', 620.0, 'PLN', '11111000000000000001',
        620.0, 'AUD', 1.0, 2410.0, '', '2020-03-26 01:34:00', 1),
       (5, 0, '11111222220000000000', 620.0, 'PLN', '11111000000000000001',
        620.0, 'AUD', 1.0, 1610.0, '', '2020-03-26 01:34:00', 1);
-- -- --

-- -- --
CREATE TABLE `letters`
(
    `letter_id`    INT(11)  NOT NULL AUTO_INCREMENT,
    `user_id`      INT(11)  NOT NULL,
    `typeQuestion` INT(11)  NOT NULL,
    `description`  TEXT,
    `date`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_processed` BOOLEAN  NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`letter_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';
-- -- --

-- -- --
CREATE TABLE `action_log`
(
    `log_entry_id` INT(11)  NOT NULL AUTO_INCREMENT,
    `user_id`      INT(11)  NOT NULL,
    `description`  TEXT     NOT NULL,
    `date`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`log_entry_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';
-- -- --