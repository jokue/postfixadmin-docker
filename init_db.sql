CREATE DATABASE IF NOT EXISTS vmail;

DROP USER `postfix`@`%`;
CREATE USER IF NOT EXISTS `postfix`@`%` IDENTIFIED BY '{{SQL_USR_PW}}';

GRANT ALL PRIVILEGES ON vmail.* TO postfix;
FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS `vmail.x_tlspolicy` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `domain` varchar(255) NOT NULL,
    `policy` enum('none', 'may', 'encrypt', 'dane', 'dane-only', 'fingerprint', 'verify', 'secure') NOT NULL,
    `params` varchar(255),
    PRIMARY KEY (`id`),
    UNIQUE KEY (`domain`)
    ) CHARSET=latin1;
