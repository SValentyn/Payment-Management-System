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
-- -- --

-- -- --
CREATE TABLE payments
(
    payment_id  INT(11) AUTO_INCREMENT,
    account_id  INT(11)      NOT NULL,
    card_number VARCHAR(255) NOT NULL,
    sum         BIGINT       NOT NULL,
    appointment VARCHAR(255),
    date        VARCHAR(255) NOT NULL,
    `condition` BOOLEAN      NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
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