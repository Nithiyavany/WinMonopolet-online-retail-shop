--COMP214-009 Assignment 4 - Group Project
--Winmonopolet Database
--Group 5
 
--PROCEDURES

-- DROP PROCEDURES SECTION
DROP PROCEDURE ORDER_RATE_AMT_SP;
DROP PROCEDURE BOTTLE_DEPOSIT_SP;

--------------------------PROCEDURE 1 ------------------------------------------
/* The ORDER_RATE_AMT_SP procedure includes one IN parameter to identify the order and five OUT parameters to
return all the values needed. */

CREATE OR REPLACE PROCEDURE ORDER_RATE_AMT_SP
 (p_ordid IN winmono_order.order_id%TYPE, 
 p_sub OUT NUMBER,
 P_tax OUT NUMBER,
 p_tax_amt OUT NUMBER,
 p_quan OUT NUMBER,
 p_totax_amt OUT NUMBER)
IS 
BEGIN
 DBMS_OUTPUT.PUT_LINE('total tax amount process called');
 SELECT SUM(subtotal_price), SUM(tax_rate), SUM(order_quantity)
 INTO p_sub, p_tax, p_quan
 FROM winmono_order
 WHERE order_id = p_ordid;
 
p_tax_amt := NVL(p_sub,0) * NVL(p_tax,0);
p_totax_amt := NVL(p_tax_amt,0) * NVL(p_quan,0);
DBMS_OUTPUT.PUT_LINE('total tax amount process ended');
END ORDER_RATE_AMT_SP;

--TESTING
DECLARE 
 lv_ordid_num winmono_order.order_id%TYPE := 3003;
 lv_sub_num NUMBER(5,2);
 lv_tax_num NUMBER(5,2);
 lv_tax_amt_num NUMBER(5,2);
 lv_quan_num NUMBER(3);
 lv_totax_amt_num NUMBER(5,2);
BEGIN
 ORDER_RATE_AMT_SP(lv_ordid_num, lv_sub_num, lv_tax_num, lv_tax_amt_num, lv_quan_num, lv_totax_amt_num);
 DBMS_OUTPUT.PUT_LINE('Tex amount of order is :' || lv_tax_amt_num);
 DBMS_OUTPUT.PUT_LINE('Tex total tax amount is :' || lv_totax_amt_num);
 END;

-------------------------- PROCEDURE 2 -----------------------------------------

/*This procedure is named BOTTLE_DEPOSIT_SP that checks whether a size of bottle is 
in the correct deposit amount. The procedure needs to accept two values as input: a deposit ID and deposit amount.*/


CREATE OR REPLACE PROCEDURE BOTTLE_DEPOSIT_SP 
  (p_id IN VARCHAR2, 
   p_amt IN NUMBER)
IS
  m_id winmono_bottle_deposit.deposit_id%TYPE;
  m_size winmono_bottle_deposit.bottle_size%TYPE;
  m_amt winmono_bottle_deposit.deposit_amount%TYPE;
  
BEGIN
  SELECT deposit_id, bottle_size, deposit_amount
  INTO m_id, m_size, m_amt
  FROM winmono_bottle_deposit
  WHERE deposit_id = p_id;
  
  IF p_amt != m_amt THEN
    RAISE_APPLICATION_ERROR(-20050 , 'INCORRECT DEPOSIT AMOUNT - Deposit amount should be' || ' '  || m_amt);
     ELSE
    DBMS_OUTPUT.PUT_LINE('CORRECT DEPOSIT AMOUNT FOR THE BOTTLE');
  END IF;
  
    EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No Amount information');
  END BOTTLE_DEPOSIT_SP;
  
--TESTING
DECLARE
  p_id VARCHAR2(5 BYTE):= 'DEP08';
  p_amt NUMBER(5,2) := 0.2;
BEGIN 
BOTTLE_DEPOSIT_SP(p_id, p_amt);
END; 