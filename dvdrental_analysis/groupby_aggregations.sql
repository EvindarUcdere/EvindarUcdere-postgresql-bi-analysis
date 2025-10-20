/*
  File: groupby_aggregations.sql
  Description: Examples demonstrating GROUP BY, aggregation functions, HAVING, and ORDER BY in PostgreSQL.
  Database: DVD Rental
*/

-- Count the number of films per rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- Count the number of films per rental rate
SELECT rental_rate, COUNT(*) AS film_count
FROM film
GROUP BY rental_rate;

-- Calculate each customer's total and maximum payment
SELECT customer_id, SUM(amount) AS total_spent, MAX(amount) AS max_payment
FROM payment
GROUP BY customer_id;

-- Calculate total and maximum payments for customers with IDs greater than 400
SELECT customer_id, SUM(amount) AS total_spent, MAX(amount) AS max_payment
FROM payment
WHERE customer_id > 400
GROUP BY customer_id;

-- Order customers by their total spending (descending)
SELECT customer_id, SUM(amount) AS total_spent, MAX(amount) AS max_payment
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- Show customers whose total spending exceeds 150
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY SUM(amount) DESC;

-- Show average film length per rating, only for ratings with an average length greater than 115 minutes
SELECT rating, AVG(length) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 115;
