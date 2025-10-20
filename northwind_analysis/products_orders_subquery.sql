-- ============================================
-- Project: Northwind Products & Orders Analysis
-- Description: Ürün fiyat analizi ve sipariş sorgulamaları


-- Query 1: Ortalama unit_price
SELECT AVG(unit_price) AS avg_unit_price
FROM products;



-- Query 2: Ortalama birim fiyatın üzerinde olan ürünler
SELECT 
    product_name, 
    unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price) 
    FROM products
);



-- Query 3: Sipariş vermemiş müşteriler

SELECT customer_id
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM orders
);

-- Query 4: Belirli tarihler arasında verilen siparişler
-- Tarihler: 1 Temmuz 1997 - 30 Ağustos 1997
SELECT *
FROM orders
WHERE order_date BETWEEN '1997-07-01' AND '1997-08-30';



-- Query 5: Belirli tarihler arasında verilen siparişlerin ürün ID'leri
-- Tekrar eden ürün ID'lerini ortadan kaldırmak için DISTINCT kullanıldı

SELECT DISTINCT product_id
FROM order_details
WHERE order_id IN (
    SELECT order_id 
    FROM orders
    WHERE order_date BETWEEN '1997-07-01' AND '1997-08-30'
);



-- Query 6: Belirli tarihler arasında verilen siparişlerin ürün adları

SELECT product_name
FROM products
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM order_details
    WHERE order_id IN (
        SELECT order_id 
        FROM orders
        WHERE order_date BETWEEN '1997-07-01' AND '1997-08-30'
    )
);
