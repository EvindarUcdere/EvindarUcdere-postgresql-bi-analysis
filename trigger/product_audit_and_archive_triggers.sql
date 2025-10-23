--products tablosundaki bir kayıt ne zaman güncellenirse, o satırın last_updated_at kolonunu otomatik olarak o anın zamanıyla dolduralım.
ALTER TABLE products ADD COLUMN last_updated_at TIMESTAMPTZ;

CREATE OR REPLACE FUNCTION fn_set_last_updated_at()
RETURNS TRIGGER 
AS $$
BEGIN 

  IF NEW IS DISTINCT FROM OLD THEN 
    NEW.last_updated_at := now();
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TRIGGER trg_set_last_updated_at 
BEFORE UPDATE ON products 
FOR EACH ROW 
EXECUTE FUNCTION fn_set_last_updated_at();

UPDATE products SET stock_quantity = 20 WHERE name ='Laptop';

SELECT name , stock_quantity , last_updated_at From products where name='Laptop';



--products tablosundan bir kayıt silindiğinde, onu tamamen kaybetmeyelim. archived_products adında bir "çöp kutusu" tablosuna taşıyalım.
CREATE TABLE archived_products (
 LIKE products INCLUDING ALL ,
 archived_At TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_archive_product()
RETURNS TRIGGER
AS $$
BEGIN
    
    INSERT INTO archived_products
    (id, name, price, stock_quantity, last_updated_at) 
    VALUES
    (OLD.id, OLD.name, OLD.price, OLD.stock_quantity, OLD.last_updated_at);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_archive_product
AFTER DELETE ON products   
FOR EACH ROW             
EXECUTE FUNCTION fn_archive_product();



DELETE FROM products WHERE id = 2;


SELECT * FROM products WHERE id = 2; 

SELECT * FROM archived_products WHERE id = 2;