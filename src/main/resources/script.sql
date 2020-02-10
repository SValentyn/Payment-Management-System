USE pms_db;

DROP TABLE IF EXISTS letters;

DROP TABLE IF EXISTS payments;

DROP TABLE IF EXISTS credit_cards;

DROP TABLE IF EXISTS accounts;

DROP TABLE IF EXISTS roles;

DROP TABLE IF EXISTS users;

-- -- --
CREATE TABLE users
(
    user_id  INT(11) AUTO_INCREMENT,
    name     VARCHAR(255) NOT NULL,
    surname  VARCHAR(255) NOT NULL,
    phone    VARCHAR(255) NOT NULL,
    email    VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    role_id  INT(11)      NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

# admin (p:111111)
INSERT INTO users (name, surname, phone, email, password, role_id)
VALUES ('Cristoforo', 'Colombo', '+393524594551', 'Cristoforo-Colombo@gmail.com', '96e79218965eb72c92a549dd5a330112',
        2);

# user (p:000000)
INSERT INTO users (name, surname, phone, email, password, role_id)
VALUES ('Fernando', 'de Magallanes', '+34645364524', 'Fernando-de-Magallanes@outlook.com',
        '670b14728ad9902aecba32e22fa4f6bd', 1);

# user (p:000001)
INSERT INTO users (name, surname, phone, email, password, role_id)
VALUES ('James', 'Cook', '+447465106475', 'James-Cook@gmail.com', '04fc711301f3c784d66955d98d399afb', 1);

# user (p:000002)
INSERT INTO users (name, surname, phone, email, password, role_id)
VALUES ('Vasco', 'da Gama', '+351919131006', 'Vasco-da-Gama@gmail.com', '768c1c687efe184ae6dd2420710b8799', 1);
-- -- --

-- -- --
CREATE TABLE roles
(
    id    INT(11) AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO roles (title)
VALUES ('client'),
       ('admin');
-- -- --

-- -- --
CREATE TABLE accounts
(
    account_id INT(11) AUTO_INCREMENT,
    user_id    INT(11)      NOT NULL,
    number     VARCHAR(255) NOT NULL,
    balance    BIGINT       NOT NULL,
    is_blocked BOOLEAN      NOT NULL,
    PRIMARY KEY (account_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (2, '00000000000000000000', 9500, false);

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (2, '11111000000000000000', 7805, false);

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (2, '11111222220000000000', 3030, false);

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (3, '00000000000000000001', 10020, true);

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (3, '11111000000000000001', 990, false);

INSERT INTO accounts (user_id, number, balance, is_blocked)
VALUES (4, '00000000000000000002', 1115, false);
-- -- --

-- -- --
CREATE TABLE credit_cards
(
    card_id    INT(11) AUTO_INCREMENT,
    account_id INT(11)      NOT NULL,
    number     VARCHAR(255) NOT NULL,
    cvv        VARCHAR(255) NOT NULL,
    validity   VARCHAR(255) NOT NULL,
    is_active  BOOLEAN      NOT NULL,
    PRIMARY KEY (card_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (1, '0000000000000000', '200', '03/21', true);

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (1, '0000007777000000', '717', '11/21', true);

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (2, '0000008888000000', '809', '09/20', false);

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (2, '0000009999000000', '191', '01/22', true);

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (3, '0000009999000000', '500', '05/21', true);

INSERT INTO credit_cards (account_id, number, cvv, validity, is_active)
VALUES (4, '4444000000000000', '404', '10/20', true);
-- -- --

-- -- --
CREATE TABLE payments
(
    payment_id               INT(11) AUTO_INCREMENT,
    account_id               INT(11)      NOT NULL,
    recipient_account_number VARCHAR(255) NOT NULL,
    sum                      BIGINT       NOT NULL,
    appointment              VARCHAR(255),
    date                     VARCHAR(255) NOT NULL,
    `condition`              BOOLEAN      NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO payments (account_id, recipient_account_number, sum, appointment, date, `condition`)
VALUES (2, '11111000000000000001', 2000, 'for accommodation', '01/02/2020', true);

INSERT INTO payments (account_id, recipient_account_number, sum, appointment, date, `condition`)
VALUES (4, '00000000000000000002', 400, 'charity', '01/10/2020', true);
-- -- --

-- -- --
CREATE TABLE letters
(
    letter_id    INT(11) AUTO_INCREMENT,
    user_id      INT(11)      NOT NULL,
    typeQuestion VARCHAR(255) NOT NULL,
    description  VARCHAR(255) NOT NULL,
    date         VARCHAR(255) NOT NULL,
    is_processed BOOLEAN      NOT NULL,
    PRIMARY KEY (letter_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
-- -- --