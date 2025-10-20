-- Query 1: Her ülkeye kaç sipariş gönderildiğini listeler

SELECT 
    ship_country,       -- Gönderim yapılan ülke
    COUNT(*) AS total_orders  -- O ülkeye gönderilen toplam sipariş sayısı
FROM orders
GROUP BY ship_country
ORDER BY total_orders DESC;



-- Query 2: En fazla ürüne sahip kategori ve ürün sayısı

SELECT 
    category_id,        -- Kategori ID'si
    COUNT(*) AS total_products  -- Kategoriye ait ürün sayısı
FROM products
GROUP BY category_id
ORDER BY total_products DESC
LIMIT 1;



-- Query 3: En yüksek toplam unit_price değerine sahip tedarikçi

SELECT 
    supplier_id,                -- Tedarikçi ID'si
    SUM(unit_price) AS total_unit_price  -- Tedarikçinin ürünlerinin toplam birim fiyatı
FROM products
GROUP BY supplier_id
ORDER BY total_unit_price DESC
LIMIT 1;
