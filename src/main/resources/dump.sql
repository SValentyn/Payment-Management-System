SET NAMES utf8;
SET CHARSET utf8;
SET CHARACTER SET utf8;

SET auto_increment_increment = 1;
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET character_set_server = utf8;

SHOW VARIABLES LIKE 'auto_inc%';
SHOW VARIABLES LIKE '%character%';
SHOW VARIABLES LIKE '%collation%';

DROP DATABASE IF EXISTS heroku_a77bbc8929247c7;

CREATE DATABASE heroku_a77bbc8929247c7
    CHARACTER SET utf8
    COLLATE utf8_general_ci;

USE heroku_a77bbc8929247c7;

DROP TABLE IF EXISTS letters;

DROP TABLE IF EXISTS payments;

DROP TABLE IF EXISTS credit_cards;

DROP TABLE IF EXISTS accounts;

DROP TABLE IF EXISTS roles;

DROP TABLE IF EXISTS users;

-- -- --
CREATE TABLE users
(
    user_id  INT(11)      NOT NULL AUTO_INCREMENT,
    name     VARCHAR(255) NOT NULL,
    surname  VARCHAR(255) NOT NULL,
    phone    VARCHAR(255) NOT NULL,
    email    VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    role_id  INT(11)      NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO users (user_id, name, surname, phone, email, password, role_id)
VALUES
# admin (pass: 111111)
       (1, 'Cristoforo', 'Colombo', '+393524594551', 'Cristoforo-Colombo@gmail.com', '96e79218965eb72c92a549dd5a330112',2),
# user (pass: 000000)
       (2, 'Fernando', 'de Magallanes', '+34645364524', 'Fernando-de-Magallanes@outlook.com','670b14728ad9902aecba32e22fa4f6bd', 1),
# user (pass: 000001)
       (3, 'James', 'Cook', '+447465106475', 'James-Cook@gmail.com', '04fc711301f3c784d66955d98d399afb', 1),
# user (pass: 000002)
       (4, 'Vasco', 'da Gama', '+351919131006', 'Vasco-da-Gama@gmail.com', '768c1c687efe184ae6dd2420710b8799', 1);
-- -- --

-- -- --
CREATE TABLE roles
(
    id    INT(11)      NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO roles (id, title)
VALUES (1, 'client'),
       (2, 'admin');
-- -- --

-- -- --
CREATE TABLE accounts
(
    account_id INT(11)      NOT NULL AUTO_INCREMENT,
    user_id    INT(11)      NOT NULL,
    number     VARCHAR(255) NOT NULL,
    balance    DOUBLE       NOT NULL,
    currency   VARCHAR(3)   NOT NULL,
    is_blocked BOOLEAN      NOT NULL,
    PRIMARY KEY (account_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO accounts (account_id, user_id, number, balance, currency, is_blocked)
VALUES (1, 2, '00000000000000000000', 9500.00, 'MXN', false),
       (2, 2, '11111000000000000000', 7805.00, 'UAH', false),
       (3, 2, '11111222220000000000', 3030.00, 'PLN', false),
       (4, 3, '00000000000000000001', 10020.00, 'YER', true),
       (5, 3, '11111000000000000001', 990.00, 'AUD', false),
       (6, 4, '00000000000000000002', 1115.00, 'MKD', false);
-- -- --

-- -- --
CREATE TABLE credit_cards
(
    card_id    INT(11)      NOT NULL AUTO_INCREMENT,
    account_id INT(11)      NOT NULL,
    number     VARCHAR(255) NOT NULL,
    cvv        VARCHAR(255) NOT NULL,
    validity   VARCHAR(255) NOT NULL,
    is_active  BOOLEAN      NOT NULL,
    PRIMARY KEY (card_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO credit_cards (card_id, account_id, number, cvv, validity, is_active)
VALUES (1, 1, '0000000000000000', '200', '03/2021', true),
       (2, 1, '0000007777000000', '717', '11/2021', true),
       (3, 2, '0000008888000000', '809', '09/2020', false),
       (4, 2, '0000009999000000', '191', '01/2022', true),
       (5, 3, '0000009999000000', '500', '05/2021', true),
       (6, 4, '4444000000000000', '404', '10/2020', true);
-- -- --

-- -- --
CREATE TABLE payments
(
    payment_id               INT(11)      NOT NULL AUTO_INCREMENT,
    account_id               INT(11)      NOT NULL,
    recipient_account_number VARCHAR(255) NOT NULL,
    sum                      DOUBLE       NOT NULL,
    appointment              VARCHAR(255),
    date                     VARCHAR(255) NOT NULL,
    `condition`              BOOLEAN      NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';

INSERT INTO payments (payment_id, account_id, recipient_account_number, sum, appointment, date, `condition`)
VALUES (1, 2, '11111000000000000001', 2000.00, 'for accommodation', '01/02/2020', true),
       (2, 4, '00000000000000000002', 400.00, 'charity', '01/10/2020', true);
-- -- --

-- -- --
CREATE TABLE letters
(
    letter_id    INT(11)      NOT NULL AUTO_INCREMENT,
    user_id      INT(11)      NOT NULL,
    typeQuestion VARCHAR(255) NOT NULL,
    description  VARCHAR(255) NOT NULL,
    date         VARCHAR(255) NOT NULL,
    is_processed BOOLEAN      NOT NULL,
    PRIMARY KEY (letter_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE = InnoDB
  CHARACTER SET utf8
  DEFAULT COLLATE 'utf8_general_ci';
-- -- --