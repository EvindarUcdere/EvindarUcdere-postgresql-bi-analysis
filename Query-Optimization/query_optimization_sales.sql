CREATE TABLE sales (
id SERIAL PRIMARY KEY ,
customer_name VARCHAR(100),
sale_date DATE,
total_amount NUMERIC
);

INSERT INTO sales(customer_name , sale_date,total_amount)
SELECT 
	'Customer_' || (random() * 1000)::INT,
    NOW() - (random() * 365)::INT * INTERVAL '1 day',
    (random() * 1000)::NUMERIC
FROM generate_series(1, 100000);

--index oladan 
EXPLAIN ANALYZE
SELECT * 
FROM sales 
WHERE total_amount> 1000



CREATE INDEX idx_sales_total_amount on sales (total_amount);

EXPLAIN ANALYZE
SELECT * 
FROM sales 
WHERE total_amount> 1000






EXPLAIN ANALYZE
SELECT * FROM sales
WHERE sale_date > NOW() - INTERVAL '7 days';


CREATE INDEX idx_sales_date ON sales(sale_date);

EXPLAIN ANALYZE
SELECT * FROM sales
WHERE sale_date > NOW() - INTERVAL '7 days';












