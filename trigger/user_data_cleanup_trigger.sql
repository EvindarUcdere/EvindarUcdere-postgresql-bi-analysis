--amacımız user tablosundaki veri bütünlügünü korumak
--Bir kullanıcı INSERT edildiğinde VEYA UPDATE edildiğinde, email ve username
--kolonlarının her zaman küçük harfli ve temiz bir şekilde kaydedildiğinden emin olmak istiyoruz.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- kirli veri ekliyoruz 
INSERT INTO users (username, email) 
VALUES ('  AdminUser  ', ' Admin@TEST.com ');


SELECT * FROM users;

Bir kullanıcı INSERT edildiğinde VEYA UPDATE edildiğinde, email ve username
kolonlarının her zaman küçük harfli ve temiz bir şekilde kaydedildiğinden emin olmak istiyoruz.


CREATE OR REPLACE FUNCTION fn_cleanup_user_data()
RETURNS TRIGGER
AS $$
BEGIN 
   IF (TG_OP = 'INSERT') THEN 
	   NEW.username := TRIM(LOWER(NEW.username));
	   NEW.email :=LOWER(NEW.email);
	

   ELSIF (TG_OP = 'UPDATE')	THEN 
		 NEW.username := TRIM(LOWER(NEW.username));
		 NEW.email :=LOWER(NEW.email);
		

   END IF;
   RETURN NEW;	

END 
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_cleanup_user_data
BEFORE INSERT OR UPDATE ON users 
FOR EACH ROW
EXECUTE FUNCTION fn_cleanup_user_data();
     
	
INSERT INTO users (username, email) 
VALUES ('  AliVeli  ', ' Ali@GMAIL.com ');


select * from users

