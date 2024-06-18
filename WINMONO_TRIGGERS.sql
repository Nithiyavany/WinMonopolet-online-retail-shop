--COMP214-009 Assignment 4 - Group Project
--Winmonopolet Database
--Group 5
 
--TRIGGERS

-- DROP TRIGGERS SECTION
DROP TRIGGER check_ship_trg;
DROP TRIGGER UPDATE_PRODUCT_TRG;

--------------------------TRIGGER 1 ------------------------------------------
 /*This trigger
fires when an UPDATE statement is attempted on a order's shipping period and checks
whether the new order's shipping date overlaps an existing order's shipping date. If so, the trigger
raises an error.*/


CREATE OR REPLACE TRIGGER  check_ship_trg  
BEFORE UPDATE OF ship_date ON WINMONO_ORDER 
FOR EACH ROW
DECLARE
 lv_ord_dt DATE;
 lv_ship_dt DATE;
BEGIN
 SELECT order_date, ship_date
 INTO lv_ord_dt, lv_ship_dt
 FROM WINMONO_ORDER
 WHERE order_id = :NEW.order_id;
IF :NEW.order_date BETWEEN lv_ord_dt AND lv_ship_dt THEN
RAISE_APPLICATION_ERROR (-20101, 'The order has already shipped!');
END IF;
END;

SELECT
    "A1"."ORDER_ID"     "ORDER_ID",
    "A1"."ORDER_DATE"   "ORDER_DATE",
    "A1"."SHIP_DATE"    "SHIP_DATE",
    "A1"."SHIP_ADDRESS" "SHIP_ADDRESS"
FROM
    "COMP214_F22_NI_22"."WINMONO_ORDER" "A1"
WHERE
    "A1"."ORDER_ID" = 3003;
    
    
--------------------------TRIGGER 2 ------------------------------------------    
 /*This trigger
fires when an UPDATE or INSERT statement is attempted on a Products stock and checks
whether the new stock value is more or less than the old one, then the stock is being updated respectfully.*/

create or replace trigger UPDATE_PRODUCT_TRG
    before insert or update of PRODUCT_STOCK
    on WINMONO_PRODUCTS
    for each row
DECLARE
BEGIN
    IF (:new.PRODUCT_STOCK > :OLD.PRODUCT_STOCK) THEN
        UPDATE WINMONO_PRODUCTS
        SET PRODUCT_STOCK=(:NEW.PRODUCT_STOCK) - (:OLD.PRODUCT_STOCK)
        WHERE PRODUCT_ID = (:OLD.PRODUCT_ID);
    ELSIF (:OLD.PRODUCT_STOCK <= 0) THEN
        UPDATE WINMONO_PRODUCTS SET PRODUCT_STOCK=(:NEW.PRODUCT_STOCK) WHERE PRODUCT_ID = (:OLD.PRODUCT_ID);

    END IF;

END;
   