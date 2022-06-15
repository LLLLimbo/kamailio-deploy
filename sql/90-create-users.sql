CREATE USER 'kamailio'@'%' IDENTIFIED BY 'kamailiorw';
CREATE USER 'kamailioro'@'%' IDENTIFIED BY 'kamailioro';
CREATE USER 'siremis'@'%' IDENTIFIED BY 'siremis';
GRANT ALL ON kamailio.* TO 'kamailio'@'%';
GRANT ALL ON mysql.* TO 'kamailio'@'%';
GRANT ALL ON kamailio.* TO 'kamailioro'@'%';
GRANT ALL ON siremis.* TO 'siremis'@'%';