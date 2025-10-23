CREATE TABLE products (
   "id" SERIAL PRIMARY  KEY ,
   name varchar(100) UNIQUE ,
   price INTEGER ,
   stock_quantity INTEGER 
);


INSERT INTO products(name,price,stock_quantity)
VALUES
   ("laptop",15000,14),
   ("mause",250,5),
   ("Keybord",2000,0)
   


--Logs table 
create table product_audit_log (
id SERIAL PRIMARY KEY ,
product_id INTEGER , 
changed_column VARCHAR (50),
old_valeu TEXT,
new_value TEXT,
change_by_user NAME DEFAULT current_user,
changed_at TIMESTAMPTZ DEFAULT now()
);


CREATE OR REPLACE FUNCTION log_product_changes()
RETURNS TRIGGER 
AS $$
BEGIN 
--did amount is change 
	IF NEW.price IS DISTINCT FROM OLD.price THEN 
	   INSERT INTO product_adit_log(product_id,changed_column,old_valeu,new_value)
	   VALUES (NEW.id ,'price', OLD.price , NEW.price);
	END IF;
	
	--did stock is change 
	IF NEW.stock_quantity IS DISTINCT FROM OLD.stock_quantity THEN 
	   INSERT INTO product_adit_log(product_id,changed_column,old_valeu,new_value)
	   VALUES (NEW.id, 'stock_quantity',OLD.stock_quantity,NEW.stock_quantity);
	
	END IF;
	
	RETURN NEW ;
END;
$$LANGUAGE plpgsql;


CREATE TRIGGER trg_log_product_changes
AFTER UPDATE ON products 
FOR EACH ROW 
WHEN (OLD IS DISTINCT FROM NEW)--for otimizasyon 
EXECUTE FUNCTION log_product_changes();



UPDATE products 
SET price = 16000, stock_quantity = 4
WHERE name = 'Laptop';


--I prevent the stock number from entering negative  
CREATE OR REPLACE   FUNCTION validate_stock()
RETURNS TRIGGER 
AS $$
BEGIN 
	IF NEW.stock_quantity < 0 THEN 
	   RAISE EXCEPTION 'Stok miktarı negatif olamaz: %', NEW.stock_quantity
	      USING HINT = 'Lütfen 0 veya daha büyük bir değer girin.',
		    ERRCODE = 'P0002';
			
    END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
	 

CREATE TRIGGER trg_validate_stock
BEFORE INSERT ON products 
FOR EACH ROW 
EXECUTE FUNCTION validate_stock();


INSERT INTO products (name, price, stock_quantity)
VALUES ('Yeni Monitör', 3000, -10);
   