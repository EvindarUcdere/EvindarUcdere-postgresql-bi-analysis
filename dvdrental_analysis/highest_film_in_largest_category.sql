-- Query 1: Her film kategorisindeki film sayısını listeler
-- Amaç: En çok filme sahip kategori tespit etmek

SELECT 
    category_id, 
    COUNT(*) AS total_films  -- Kategorideki toplam film sayısı
FROM film_category
GROUP BY category_id
ORDER BY total_films DESC;



-- Query 2: Belirli kategori (örneğin category_id = 15) içindeki 
-- en yüksek film_id'ye sahip filmi bulma

SELECT 
    film_id
FROM film_category
WHERE category_id = 15
ORDER BY film_id DESC
LIMIT 1;



-- Query 3: En çok filme sahip kategorideki en yüksek film_id'ye sahip film

SELECT 
    film_id
FROM film_category
WHERE category_id = (
    SELECT category_id
    FROM (
        SELECT 
            category_id, 
            COUNT(*) AS film_count
        FROM film_category
        GROUP BY category_id
        ORDER BY film_count DESC
        LIMIT 1
    ) AS top_category
)
ORDER BY film_id DESC
LIMIT 1;
