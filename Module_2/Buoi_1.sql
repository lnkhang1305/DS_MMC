-- Active: 1714637042800@@127.0.0.1@3306@sale_management
CREATE DATABASE Sale_Management;
USE Sale_Management;
CREATE TABLE customers (
    customer_id             INT,
    first_name              VARCHAR(50),
    last_name               VARCHAR(50),
    email_address           VARCHAR(50),
    number_of_complaints    INT
);
CREATE TABLE SALES (
    purchase_number         INT,
    date_of_purchase        DATE,
    customer_id             INT,
    item_code               VARCHAR(3)
);
CREATE TABLE Items (
    item_code                   VARCHAR(3),
    item                        VARCHAR(50),
    unit_price_usd              INT,
    company_id                  INT,
    company                     VARCHAR(50),
    headquarters_phone_number   VARCHAR(50)
);