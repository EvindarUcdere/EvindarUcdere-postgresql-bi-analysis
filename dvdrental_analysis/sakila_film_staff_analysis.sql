-- ============================================
-- Project: Sakila Film & Staff Analysis
-- Description: Film kiralama, ödeme, aktör ve kategori analizleri
-- ============================================

-- ============================================
-- Query 1: Ortalama kiralama ücretinden yüksek olan film sayısı
-- ============================================
-- Ortalama kiralama ücretini hesapla
SELECT AVG(rental_rate) AS avg_rental_rate
FROM film;

-- Ortalama kiralama ücretinden yüksek olan film sayısı
SELECT COUNT(*) AS films_above_avg_rental
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate) FROM film
);


-- ============================================
-- Query 2: En çok ödeme yapan çalışan bilgisi
-- ============================================
-- En çok ödeme yapan staff_id
SELECT staff_id, SUM(amount) AS total_payment
FROM payment
GROUP BY staff_id
ORDER BY total_payment DESC
LIMIT 1;

-- En çok ödeme yapan çalışanın adı ve soyadı
SELECT first_name, last_name
FROM staff
WHERE staff_id = (
    SELECT staff_id
    FROM payment
    GROUP BY staff_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);


-- ============================================
-- Query 3: En çok filmde oynayan aktör bilgisi
-- ============================================
-- En çok filmde rol alan aktörün ID'si
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- En çok filmde rol alan aktörün adı ve soyadı
SELECT first_name, last_name
FROM actor
WHERE actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- ============================================
-- Query 4: En çok filme sahip kategori
-- ============================================
-- Tek bir kategori
SELECT name AS category_name
FROM category
WHERE category_id = (
    SELECT category_id
    FROM film_category
    GROUP BY category_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- En çok filme sahip 3 kategori
SELECT name AS category_name
FROM category
JOIN (
    SELECT category_id
    FROM film_category
    GROUP BY category_id
    ORDER BY COUNT(*) DESC
    LIMIT 3
) AS most_film_category 
ON category.category_id = most_film_category.category_id;
