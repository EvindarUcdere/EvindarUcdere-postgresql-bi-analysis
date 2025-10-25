-- Price change log table
CREATE TABLE price_change_log (
    id SERIAL PRIMARY KEY,
    product_id INTEGER,
    old_price NUMERIC(10, 2),
    new_price NUMERIC(10, 2),
    percentage_change NUMERIC(5, 2),
    changed_at TIMESTAMPTZ DEFAULT now()
);

-- Function to prevent more than 50% price increase
CREATE OR REPLACE FUNCTION fn_check_price_hike_limit()
RETURNS TRIGGER 
AS $$
BEGIN
    IF NEW.price > OLD.price + (OLD.price / 2) THEN
        RAISE EXCEPTION 'Bir ürüne %%50''den fazla zam yapamazsınız';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to log every price change
CREATE OR REPLACE FUNCTION fn_log_price_change()
RETURNS TRIGGER 
AS $$ 
DECLARE
    v_percentage_change NUMERIC(5, 2);
BEGIN 
    IF OLD.price IS DISTINCT FROM NEW.price THEN 
        IF OLD.price = 0 OR OLD.price IS NULL THEN
            v_percentage_change := 0.00;
        ELSE
            v_percentage_change := ((NEW.price - OLD.price) / OLD.price) * 100;
        END IF;

        INSERT INTO price_change_log (product_id, old_price, new_price, percentage_change)
        VALUES (NEW.id, OLD.price, NEW.price, v_percentage_change);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers
CREATE TRIGGER trg_check_price_hike_limit
BEFORE UPDATE ON products 
FOR EACH ROW 
EXECUTE FUNCTION fn_check_price_hike_limit();

CREATE TRIGGER trg_log_price_change
AFTER UPDATE ON products
FOR EACH ROW 
EXECUTE FUNCTION fn_log_price_change();


--test 
UPDATE products SET price = 20000 WHERE name = 'Laptop';
SELECT * FROM price_change_log WHERE product_id = 1;

UPDATE products 
SET price = 1300 
WHERE name = 'Klavye';