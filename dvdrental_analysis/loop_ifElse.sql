CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2)
);
INSERT INTO products (name, price) VALUES ('Laptop', 15000), ('Mouse', 250);


ALTER TABLE products ADD COLUMN stock_quantity INTEGER DEFAULT 0;
UPDATE products SET stock_quantity = 10 WHERE id = 1;
UPDATE products SET stock_quantity = 50 WHERE id = 2;


-- Function: urun_stok_degeri(urun_id INTEGER)
-- This function calculates the total stock value of a product
-- by multiplying its price with stock_quantity and returns it as NUMERIC.


Create or replace function urun_stok_degeri(urun_id INTEGER)
returns numeric (10,2)
as $$
DECLARE 
   total_stoc NUMERIC(10,2);

BEGIN 
   SELECT 
      price*stock_quantity 

   INTO 
     total_stoc
	  
   from products 
   where 
     products.id=urun_id;
  
   RETURN total_stoc;
END;
$$ LANGUAGE plpgsql;


----------  if-else   -----------


CREATE OR REPLACE FUNCTION urun_durumu(urun_id integer)
RETURNS TEXT 
AS $$
DECLARE 
  u_fiyat NUMERIC ;
BEGIN 
  SELECT price INTO u_fiyat 
  FROM products 
  WHERE id = urun_id ;


  IF u_fiyat IS NULL THEN
     RETURN 'Ürün bulunamadı';
  END IF;


  IF u_fiyat >10000 THEN 
     RETURN 'Çok pahalı';

  ELSIF u_fiyat > 1000 then 
     RETURN 'Normal';

  ELSIF u_fiyat >0 THEN 
     RETURN 'Uygun';

  ELSE 
    RETURN 'Fiyat bilgisi yok ';

  END IF ;

END ;  

$$ LANGUAGE plpgsql;

-- Test edelim
SELECT urun_durumu(1); -- Laptop (15000) -> 'Çok Pahalı'
SELECT urun_durumu(2); -- Mouse (250) -> 'Normal'
SELECT urun_durumu(999); -- (Yok) -> 'Ürün bulunamadı!'



------------------	loop	--------------------------
--we use a FOR ... IN SELECT loop in PL/pgSQL. 

CREATE OR REPLACE FUNCTION tum_stok_degerlerini_goster()
RETURNS VOID 
AS $$
DECLARE 

   r RECORD;
   stok_degeri NUMERIC;

BEGIN 
   RAISE NOTICE '--Stok değer raporu başlıyor ---';
   FOR r IN 
     SELECT name , price ,stock_quantity
	 FROM products 
	 WHERE stock_quantity >0 
   LOOP 
     stok_degeri := r.price * r.stock_quantity;

	 RAISE NOTICE 'Ürün : % ,toplam Değer : %',r.name ,stok_degeri;
    END LOOP ; 
	RAISE NOTICE '--Rapor bitti ';


END 
$$ LANGUAGE plpgsql ;



SELECT tum_stok_degerlerini_goster();


