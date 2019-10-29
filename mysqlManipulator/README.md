# Prerequisistes
CREATE USER 'exampleuser'@'localhost' IDENTIFIED BY 'example20141024';
CREATE USER 'exampleuser'@'10.%' IDENTIFIED BY 'example20141024';
CREATE USER 'exampleuser'@'172.%' IDENTIFIED BY 'example20141024';
CREATE USER 'exampleuser'@'192.%' IDENTIFIED BY 'example20141024';
CREATE DATABASE example CHARACTER SET utf8mb4;
GRANT ALL PRIVILEGES ON example.* TO 'exampleuser'@'localhost';
GRANT ALL PRIVILEGES ON example.* TO 'exampleuser'@'10.%';
GRANT ALL PRIVILEGES ON example.* TO 'exampleuser'@'172.%';
GRANT ALL PRIVILEGES ON example.* TO 'exampleuser'@'192.%';
