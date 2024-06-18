--COMP214-009 Assignment 4 - Group Project
--Winmonopolet Database
--Group 5
 
--FUNCTIONS

-- DROP FUNCTIONS SECTION
DROP PROCEDURE CUS_DETAIL_SF;
DROP PROCEDURE SHIP_COST_SF;
DROP FUNCTION a_func_cal_bottle_deposit;
DROP FUNCTION a_func_check_availability;

-----------------------------FUNCTION 1------------------------------------------

/*The CUS_DETAIL_SF function accepts six input values and returns a formatted string 
containing customer ID and other information:*/

CREATE OR REPLACE FUNCTION CUS_DETAIL_SF
(p_id IN NUMBER,
p_first IN VARCHAR2,
p_last IN VARCHAR2,
p_email IN VARCHAR2,
p_address IN VARCHAR2,
p_city IN VARCHAR2)
RETURN VARCHAR2
IS
lv_cust_txt VARCHAR2(255);

BEGIN
lv_cust_txt := 'Customer' || ' ' || 'ID' ||' '|| p_id || ' ' || 'deatils are :-' || p_first || ' '|| p_last ||', '|| p_email ||', '|| p_address ||', '|| p_city;
RETURN lv_cust_txt;
END;

--TESTING

DECLARE
lv_cust_txt VARCHAR2(255);
p_id winmono_customer.customer_id%Type;
p_first winmono_customer.first_name%Type;
p_last winmono_customer.last_name%Type;
p_email winmono_customer.email%Type;
p_address winmono_customer.address%Type;
p_city winmono_customer.city%Type;

BEGIN 
SELECT customer_id, first_name, last_name, email, address, city
INTO p_id, p_first, p_last, p_email, p_address, p_city
FROM winmono_customer
WHERE customer_id = 2208;

lv_cust_txt := CUS_DETAIL_SF( p_id, p_first, p_last, p_email, p_address, p_city);
DBMS_OUTPUT.PUT_LINE(lv_cust_txt);
END;


-----------------------------FUNCTION 2------------------------------------------

/*The SHIP_COST_SF function calculates shipping cost based on shipping province*/

CREATE OR REPLACE FUNCTION SHIP_COST_SF
(p_prov IN VARCHAR2)
RETURN NUMBER
IS
lv_ship_cost NUMBER(5,2);
BEGIN
IF p_prov='ON' THEN
lv_ship_cost:=10.00;
ELSIF p_prov='QC' THEN
lv_ship_cost:=12.00;
ELSIF p_prov='MB' AND p_prov='SK' THEN
lv_ship_cost:=15.00;
ELSIF p_prov='AB' AND p_prov='BC' THEN
lv_ship_cost:=20.00;
ELSE
lv_ship_cost:=35.00;
END IF;
RETURN lv_ship_cost;
END;

--TESTING
DECLARE
lv_ship_cost NUMBER(5,2);
BEGIN
lv_ship_cost:=SHIP_COST_SF('YT');
DBMS_OUTPUT.PUT_LINE(lv_ship_cost);
END;

--TESTING
SELECT total_price, SHIP_COST_SF(ship_province) shipping_cost
FROM WINMONO_ORDER
WHERE order_id=3001;

-----------------------------FUNCTION 3------------------------------------------
create function a_func_cal_bottle_deposit(p_id in varchar2)
    return number
    is
    l_bottle_size number;
    p_cat_id      number;
    l_price       number;
begin
    select BOTTLE_SIZE, PRODUCT_PRICE, CATEGORY_ID
    into l_bottle_size, l_price, p_cat_id
    from WINMONO_PRODUCTS
    where PRODUCT_ID = p_id;
    IF p_cat_id = 1003 and l_bottle_size >= 500 THEN
        l_price := l_price + l_price * 0.20;
    ELSIF p_cat_id = 1003 and l_bottle_size < 500 THEN
        l_price := l_price + l_price * 0.10;
    ELSIF p_cat_id = 1002 THEN
        l_price := l_price + l_price * 0.10;
    ELSe
        l_price := l_price;
        --RAISE_APPLICATION_ERROR(-20101, 'order quantity exceeded');
    END IF;
    return l_price;
end;

----------------------------FUNCTION 4----------------------------------
create function a_func_check_availability(p_id in varchar2, qty in number)
    return varchar2
is
    l_result   varchar2(132) := ''; --> should match RETURN datatype
    l_quantity number;
begin
    select QUANTITY into l_quantity from WINMONO_ORDER_ITEMS where PRODUCT_ID = p_id;
    IF qty <= 0 THEN
        l_result := 'order quantity must be grater than 0';

    ELSIF l_quantity < qty THEN
        l_result := 'order quantity not available';
    ELSe
        l_result := 'order quantity available for sale';
        --RAISE_APPLICATION_ERROR(-20101, 'order quantity exceeded');
    END IF;
    return l_result;
end;
