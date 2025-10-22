--------------  EXCEPTION  --------------

CREATE OR REPLACE FUNCTION urun_bilgisi_guvenli_getir(urun_id INTEGER)
RETURNS TEXT 
AS $$
DECLARE 
   urun_adi VARCHAR;

BEGIN 

  BEGIN 
     SELECT name 
	 INTO STRICT urun_adi
	 FROM products
	 WHERE id =urun_id ;

	 RETURN 'Ürün Adi:'  || urun_adi;
	 

   EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
	    RETURN 'HATA: Bu ID''de bir ürün bulunamadı!';


	  WHEN TOO_MANY_ROWS THEN 
	    RETURN 'HATA: Beklenmedik bir durum , birden fazla ürün bulundu!'; 

	END;
END;
$$ LANGUAGE plpgsql;



SELECT urun_bilgisi_guvenli_getir(1);   -- Çıktı: 'Ürün Adı: Laptop'
SELECT urun_bilgisi_guvenli_getir(999);


--unique_violation exception 

--I added  a unique constraint to the  name column in the  products table 
ALTER TABLE products ADD CONSTRAINT products_name_unique_ UNIQUE (name);

CREATE OR REPLACE FUNCTION new_product_add(p_name VARCHAR, p_price NUMERIC)
RETURNS TEXT 
AS $$
BEGIN
  INSERT INTO products (name, price, stock_quantity)
  VALUES (p_name, p_price, 0);

  RETURN 'Successful: ' || p_name || ' added.';
  
EXCEPTION
  WHEN unique_violation THEN 
    RETURN 'Error: ' || p_name || ' already exists.';

  WHEN OTHERS THEN 
    RETURN 'Error: An unexpected error occurred.';
END;
$$ LANGUAGE plpgsql;



SELECT new_product_add('Laptop', 12000);
SELECT new_product_add('Klavye', 800);


CREATE OR REPLACE FUNCTION stock_update(product_id INTEGER ,amount INTEGER)
RETURNS VOID
AS $$
BEGIN 
  IF amount <= 0 THEN 
    RAISE EXCEPTION 'the amount must be  greater than zero ' --this is what the wrong 
	  USING HINT = 'please enter a positive value.', -- we can how this fix it 
	    ERRCODE ='P0001';
  END IF ;
  update products 
  SET stock_quantity = stock_quantity+amount
  WHERE id = product_id;

END;
$$ LANGUAGE plpgsql;

SELECT stock_update(1, -5);
	  
  
