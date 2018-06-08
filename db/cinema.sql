DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
id serial4 PRIMARY KEY,
name VARCHAR(255),
wallet INT4
);

CREATE TABLE films (
id serial4 PRIMARY KEY,
title VARCHAR(255),
price INT4
);

CREATE TABLE tickets (
id serial4 PRIMARY KEY,
customer_id INT4 REFERENCES customers(id),
film_id INT4 REFERENCES films(id)
);
