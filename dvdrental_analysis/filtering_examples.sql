/*
  File: filtering_examples.sql
  Description: Filtering and conditional selection examples in PostgreSQL
  Database: DVD Rental
*/

-- Retrieve title, description, and rating from the film table
SELECT title, description, rating
FROM film;

-- Retrieve films with rating = 'G'
SELECT title, rating
FROM film
WHERE rating = 'G';

-- Retrieve films with a duration less than or equal to 100 minutes
SELECT title, length
FROM film
WHERE length <= 100;

-- Retrieve all film information where rental_rate is not equal to 0.99
SELECT *
FROM film
WHERE rental_rate != 0.99;

-- Retrieve films where rental_rate is not equal to 4.99 (alternative syntax)
SELECT *
FROM film
WHERE rental_rate <> 4.99;

-- Retrieve films with length between 90 and 100 minutes
SELECT *
FROM film
WHERE length BETWEEN 90 AND 100;

-- Retrieve films NOT between 90 and 100 minutes
SELECT *
FROM film
WHERE length NOT BETWEEN 90 AND 100;

-- Retrieve films with rental_rate equal to 0.99 or 4.99
SELECT *
FROM film
WHERE rental_rate IN (0.99, 4.99);

-- Retrieve films with rental_rate NOT equal to 0.99 or 4.99
SELECT *
FROM film
WHERE rental_rate NOT IN (0.99, 4.99);

-- Retrieve films with rental_rate in (0.99, 2.99), length between 100 and 130, and rating = 'PG'
SELECT *
FROM film
WHERE rental_rate IN (0.99, 2.99)
  AND length BETWEEN 100 AND 130
  AND rating = 'PG';

-- Retrieve films where rating is 'G' OR (rating is 'R' AND rental_duration = 3)
SELECT *
FROM film
WHERE rating = 'G'
   OR (rating = 'R' AND rental_duration = 3);

-- Retrieve films where rating is 'G' or 'R' AND rental_duration = 3
SELECT *
FROM film
WHERE (rating = 'G' OR rating = 'R')
  AND rental_duration = 3;

-- Retrieve actors where first_name = 'Penelope' AND last_name = 'Guiness' OR first_name = 'Nick'
SELECT *
FROM actor
WHERE (first_name = 'Penelope' AND last_name = 'Guiness')
   OR first_name = 'Nick';
