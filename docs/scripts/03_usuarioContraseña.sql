CREATE USER 'ferreteria '@'%' IDENTIFIED BY 'ferreteria';
GRANT SELECT, INSERT, UPDATE, DELETE ON ferreteria.* TO 'ferreteria'@'%';

SELECT User, Host FROM mysql.user WHERE User = 'ferreteria';
GRANT SELECT, INSERT, UPDATE, DELETE ON ferreteria.* TO 'ferreteria '@'%';


ALTER USER 'ferreteria ' IDENTIFIED BY 'ferreteria11';

SELECT User, Host FROM mysql.user WHERE User = 'ferreteria';

SHOW GRANTS FOR 'ferreteria'@'localhost';

DROP USER 'ferreteria '@'%';

CREATE USER 'ferreteria'@'localhost' IDENTIFIED BY 'ferreteria11';

GRANT ALL PRIVILEGES ON ferreteria.* TO 'ferreteria'@'localhost' IDENTIFIED BY 'ferreteria11';