DROP DATABASE IF EXISTS murder_mystery;
CREATE DATABASE murder_mystery;
USE murder_mystery;

DROP TABLE IF EXISTS crime_scene_report;
CREATE TABLE crime_scene_report (
        date integer,
        type text,
        description text,
        city text);

DROP TABLE IF EXISTS drivers_license;
CREATE TABLE drivers_license (
        id integer PRIMARY KEY,
        age integer,
        height integer,
        eye_color text,
        hair_color text,
        gender text,
        plate_number text,
        car_make text,
        car_model text);

DROP TABLE IF EXISTS facebook_event_checkin;        
CREATE TABLE facebook_event_checkin (
        person_id integer,
        event_id integer,
        event_name text,
        date integer);

DROP TABLE IF EXISTS get_fit_now_check_in;
CREATE TABLE get_fit_now_check_in (
        membership_id text,
        check_in_date integer,
        check_in_time integer,
        check_out_time integer);

DROP TABLE IF EXISTS get_fit_now_member;
CREATE TABLE get_fit_now_member (
        id varchar(30) PRIMARY KEY,
        person_id integer,
        name text,
        membership_start_date integer,
        membership_status text);

DROP TABLE IF EXISTS income;        
CREATE TABLE income (
		ssn CHAR PRIMARY KEY,
        annual_income integer);

DROP TABLE IF EXISTS interview;
CREATE TABLE interview (
        person_id integer,
        transcript text);

DROP TABLE IF EXISTS person;        
CREATE TABLE person (
		id integer PRIMARY KEY,
        name text,
        license_id integer,
        address_number integer,
        address_street_name text,
        ssn CHAR);