--COMP214-009 Assignment 4 - Group Project
--Winmonopolet Database
--Group 5
 
--SEQUENCES

--DROP SEQUENCES SECTION
DROP SEQUENCE WINMONO_CUSTOMER_SEQ;
DROP SEQUENCE WINMONO_ORDER_SEQ;

--Creating Sequence on WINMONO_CUSTOMER Table
CREATE SEQUENCE WINMONO_CUSTOMER_SEQ
    START WITH 2211
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCACHE
    NOCYCLE;    
    
--Testing 
INSERT INTO WINMONO_CUSTOMER
    (customer_id, firstname, lastname, email, street, city, province, postal_code, country, phone)
    VALUES
    (WINMONO_CUSTOMER_SEQ.NEXTVAL, 2211, 'John', 'Smith', 'j.smith@yahoo.ca', '1008 A Avenue', 'Edmonton', 'AB', 'T5J 0K7', 'Canada', 7809176595);

--Creating Sequence on WINMONO_ORDER Table
CREATE SEQUENCE WINMONO_ORDER_SEQ
    START WITH 3011
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCACHE
    NOCYCLE;    
    
--Testing
INSERT INTO WINMONO_ORDER
    (order_id, customer_id, order_date, ship_date, ship_address, ship_city, ship_province, ship_postal_code, ship_country, subtotal_price, discount, tax_rate, total_price, order_quantity)
    VALUES
    (WINMONO_ORDER_SEQ.NEXTVAL, 3011, 2211, '15-MAY-2022', '16-MAY-2022', '526 Maple Street', 'Montreal', 'QB', 'Q4H 5F1', 'Canada', 240.50, 10.00, 0.13, 260.40, 10);

--Checking Sequences
SELECT * FROM USER_SEQUENCES;

