CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    product_count INTEGER DEFAULT 0
);
ALTER TABLE products ADD COLUMN category_id INTEGER REFERENCES categories(id);


INSERT INTO categories (name) VALUES ('Elektronik'), ('Aksesuar');


UPDATE products SET category_id = (SELECT id FROM categories WHERE name = 'Elektronik') WHERE name = 'Laptop';
UPDATE products SET category_id = (SELECT id FROM categories WHERE name = 'Aksesuar') WHERE name = 'Mouse';


UPDATE categories SET product_count = 1 WHERE name = 'Elektronik';
UPDATE categories SET product_count = 1 WHERE name = 'Aksesuar';



--TG_OP değişkenini kullanacagız INSERT ,UPDATE ve DELETE'yi yönetebilmek için 


CREATE OR REPLACE FUNCTION fn_update_category_count()
RETURNS TRIGGER
AS $$
BEGIN 

	IF (TG_OP ='INSERT') THEN 
	   UPDATE categories 
	   SET product_count = product_count+1
	   where id = NEW.category_id ;
	   RETURN NEW;


	ELSIF (TG_OP ='DELETE') THEN 

	   UPDATE categories
	   SET product_count = product_count-1
	   WHERE id = OLD.category_id;
	   RETURN OLD;

	ELSIF (TG_OP ='UPDATE') THEN 
   
	  IF NEW.category_id IS DISTINCT FROM OLD.category_id THEN 
		  UPDATE categories
		  SET product_count = product_count-1
		  WHERE id = OLD.category_id;
	
		  UPDATE categories
		  SET product_count=product_count +1
		  WHERE id = NEW.category_id;

   	  END IF;
	  RETURN NEW;
  END IF;
  RETURN NULL;
END 
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_category_count
AFTER INSERT OR DELETE OR UPDATE OF category_id ON products
FOR EACH ROW 
EXECUTE FUNCTION fn_update_category_count();
	  
   
INSERT INTO products (name ,price,stock_quantity,category_id)
VALUES ('klavye',800,30,(SELECT id FROM categories WHERE name = 'Aksesuar'))

UPDATE products 
SET category_id = (SELECT id FROM categories WHERE name ='Aksesuar')
WHERE name = 'Laptop';

DELETE FROM products WHERE name ='Mouse';



SELECT * FROM categories ORDER BY id;











