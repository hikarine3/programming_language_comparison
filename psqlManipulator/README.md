# Prerequisistes
CREATE USER exampleuser PASSWORD 'example20141024';
CREATE DATABASE example;
GRANT ALL ON DATABASE example TO exampleuser;
CREATE TYPE sex_example AS ENUM ('male', 'female');
