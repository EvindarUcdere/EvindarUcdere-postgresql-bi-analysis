/*
  File: string_functions_examples.sql
  Description: Basic string manipulation examples in PostgreSQL
  Database: DVD Rental
*/

-- Retrieve all columns from the film table
SELECT * FROM film;

-- Retrieve specific columns
SELECT title, description FROM film;

-- Combine two columns (first_name and last_name) into one as "full_name"
SELECT first_name || ' ' || last_name AS full_name
FROM actor;

-- Alternative approach using CONCAT function
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;

-- Convert first_name to uppercase
SELECT UPPER(first_name) AS upper_name
FROM actor;

-- Convert last_name to lowercase
SELECT LOWER(last_name) AS lower_lastname
FROM actor;

-- Get the first five characters of the film title in uppercase
SELECT UPPER(SUBSTRING(title, 1, 5)) AS short_title
FROM film;

-- Get the length of the film title
SELECT LENGTH(title) AS title_length
FROM film;
