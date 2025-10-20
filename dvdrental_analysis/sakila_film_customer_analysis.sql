-- Project: Sakila Film & Customer Analysis
-- Description: Film uzunluğu, kategori ve müşteri şehir analizi



-- Query 1: En uzun filmin adı ve uzunluğu


SELECT 
    title, 
    length
FROM film
ORDER BY length DESC
LIMIT 1;



-- Query 2: "Action" kategorisindeki filmler
-- Not: category_id = 1 Action kategorisi varsayılmıştır

SELECT 
    f.title, 
    fc.category_id
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
WHERE fc.category_id = 1;



-- Query 3: Müşteri tablosunda en çok kullanılan şehir



SELECT 
    c.city, 
    COUNT(c.city) AS customer_count
FROM customer AS cu
INNER JOIN address AS a ON cu.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
GROUP BY c.city
ORDER BY customer_count DESC
LIMIT 1;
