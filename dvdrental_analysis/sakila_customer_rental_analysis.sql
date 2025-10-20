-- ============================================
-- Project: Sakila Database Analysis
-- Description: Örnek SQL sorguları; aktörler, müşteriler, kiralamalar ve ödemeler üzerine analizler
-- ============================================

-- Query 1: En çok filmde rol alan 3 aktör ve oynadıkları film sayısı
SELECT 
    a.first_name, 
    a.last_name, 
    COUNT(*) AS total_films  -- Aktörün rol aldığı film sayısı
FROM actor AS a
INNER JOIN film_actor AS fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_films DESC
LIMIT 3;


-- Query 2: En fazla ödeme yapan müşteri
SELECT 
    customer_id, 
    SUM(amount) AS total_payment  -- Müşterinin yaptığı toplam ödeme
FROM payment
GROUP BY customer_id
ORDER BY total_payment DESC
LIMIT 1;


-- Query 3: En çok kiralanan 5 filmi (film adı ve kiralanma sayısı)
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count  -- Filmin kiralanma sayısı
FROM film AS f
INNER JOIN inventory AS i ON i.film_id = f.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;


-- Query 4: Her mağazada kaç müşteri var
SELECT 
    store_id, 
    COUNT(*) AS total_customers
FROM customer
GROUP BY store_id
ORDER BY total_customers DESC;


-- Query 5: 2005 yılında yapılan toplam ödeme miktarı
SELECT 
    SUM(amount) AS total_payment_2005
FROM payment
WHERE payment_date >= '2005-01-01' 
  AND payment_date < '2006-01-01';


-- Query 6: En çok kiralama yapan müşteri (ad-soyad ve toplam kiralama sayısı)
SELECT 
    c.first_name, 
    c.last_name,
    p.customer_id,
    COUNT(p.customer_id) AS total_rentals
FROM payment AS p
INNER JOIN customer AS c ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, p.customer_id
ORDER BY total_rentals DESC
LIMIT 1;
