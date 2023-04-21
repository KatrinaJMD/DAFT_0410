create database IF NOT EXISTS lab_mysql;
use lab_mysql;

DROP TABLE IF EXISTS cars;
create table cars (
	id tinyint AUTO_INCREMENT not null,  
	vin varchar(20) not null,
    manufacturer varchar(30) not null,
    model varchar(20) not null,
    year int(4) not null,
    color varchar(10),
    PRIMARY KEY (id));

DROP TABLE IF EXISTS customers;
create table customers (
	id tinyint AUTO_INCREMENT not null,
	customer_id int(5) not null,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    phone varchar(20) not null,
    email varchar(30) default null,
    address varchar(30) default null,
    city varchar(10) not null,
    state_province varchar(15) not null,
    country varchar(15) not null,
    zipcode int(5) not null,
    PRIMARY KEY (id));
    
DROP TABLE IF EXISTS salespersons;
create table salespersons (
	staff_id tinyint AUTO_INCREMENT not null,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    store varchar(15) not null,
    PRIMARY KEY (staff_id));

DROP TABLE IF EXISTS invoices;
create table invoices (
	id tinyint AUTO_INCREMENT not null,
    invoice_no int(10) not null,
	date date not null,
    car tinyint(1) not null,
    customer tinyint(1) not null,
    salesperson tinyint(1) not null,
    PRIMARY KEY (id));