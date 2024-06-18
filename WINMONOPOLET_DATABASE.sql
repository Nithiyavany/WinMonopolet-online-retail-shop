--COMP214-009 Assignment 4 - Group Project
--Winmonopolet Database
--Group 5

--DATABASE CREATION AND DATA INSERT

-- ALTER SESSION: SET DATE FORMAT
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

-- DROP TABLES, VIEWS, PROCEDURES, TRIGGERS, ETC.

DROP TABLE WINMONO_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE WINMONO_BRAND CASCADE CONSTRAINTS;
DROP TABLE WINMONO_PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE WINMONO_CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE WINMONO_ORDER CASCADE CONSTRAINTS;
DROP TABLE WINMONO_ORDER_ITEMS CASCADE CONSTRAINTS;
DROP TABLE WINMONO_TAX CASCADE CONSTRAINTS;
DROP TABLE WINMONO_BOTTLE_DEPOSIT CASCADE CONSTRAINTS;
DROP TABLE WINMONO_INVOICE CASCADE CONSTRAINTS;
DROP TABLE WINMONO_BASKET CASCADE CONSTRAINTS;

-- CREATE TABLES
--1 table
CREATE TABLE WINMONO_CATEGORY       
(category_id VARCHAR2(15) PRIMARY KEY NOT NULL,       
category_name VARCHAR(20) NOT NULL,       
category_desc VARCHAR(150));

--2 table
CREATE TABLE WINMONO_BRAND
(brand_id VARCHAR2(15) NOT NULL,
brand_name VARCHAR(50) NOT NULL,
brand_desc VARCHAR2(350),
CONSTRAINT WINMONO_BRAND_brand_id_PK PRIMARY KEY (brand_id));

--3 table
CREATE TABLE WINMONO_PRODUCTS
(product_id VARCHAR2(15) NOT NULL,
product_name VARCHAR2(50) NOT NULL,
category_id VARCHAR2 (15) NOT NULL,
brand_id VARCHAR2(15) NOT NULL,
bottle_size NUMBER(5),
product_desc VARCHAR(370),
product_price NUMBER(5,2),
product_stock NUMBER (5),
CONSTRAINT WINMONO_PRODUCTS_product_id_PK PRIMARY KEY (product_id),
FOREIGN KEY (category_id) REFERENCES WINMONO_CATEGORY (category_id),
FOREIGN KEY (brand_id) REFERENCES WINMONO_BRAND (brand_id));

--4 table
CREATE TABLE WINMONO_CUSTOMER
(customer_id VARCHAR2(15) PRIMARY KEY NOT NULL,
first_name VARCHAR2(50) NOT NULL,       
last_name VARCHAR2(50) NOT NULL,
email VARCHAR2(50),
address VARCHAR2(40),
city VARCHAR2(20),
province VARCHAR2(3),
postal_code VARCHAR2(15),
country VARCHAR2(15),
pnone VARCHAR2(10));

--5 table
CREATE TABLE WINMONO_ORDER
(order_id NUMBER(5) NOT NULL,  
customer_id VARCHAR2(15),
order_date DATE NOT NULL,
ship_date DATE,
ship_address VARCHAR2(40),
ship_city VARCHAR2(20),
ship_province VARCHAR2(3),
ship_postal_code VARCHAR2(15),
ship_country VARCHAR2(15),
subtotal_price NUMBER (5,2),
discount NUMBER (5,2),
tax_rate NUMBER (5,2),
total_price NUMBER(5,2),
order_quantity NUMBER(3,0),
CONSTRAINT WINMONO_ORDER_order_id_PK PRIMARY KEY (order_id),
FOREIGN KEY (customer_id) REFERENCES WINMONO_CUSTOMER (customer_id)); 

--6 table
CREATE TABLE WINMONO_ORDER_ITEMS
(item_id VARCHAR(10),
product_id VARCHAR2(15),             
order_id NUMBER (5),
quantity NUMBER (3,0),
bottle_deposit NUMBER (5,2),
 CONSTRAINT WINMONO_ORDER_ITEMS_item_id_PK PRIMARY KEY (item_id),
 FOREIGN KEY (product_id) REFERENCES WINMONO_PRODUCTS (product_id),
 FOREIGN KEY (order_id) REFERENCES WINMONO_ORDER (order_id)); 

--7 table 
CREATE TABLE WINMONO_TAX
(tax_id VARCHAR(5),
province_code VARCHAR(5),
province_name VARCHAR(50),
tax_rate NUMBER (5,2),
CONSTRAINT WINMONO_TAX_tax_id_PK PRIMARY KEY (tax_id));

--8 table
CREATE TABLE WINMONO_BOTTLE_DEPOSIT
(deposit_id VARCHAR(5) PRIMARY KEY NOT NULL,
bottle_size NUMBER(5),
deposit_amount NUMBER(5,2));
 
--9 table
CREATE TABLE WINMONO_INVOICE
(invoice_id NUMBER (10) PRIMARY KEY NOT NULL, 
order_id NUMBER(5),
customer_id VARCHAR2(15),
purchase_date DATE,
ship_date DATE,
invoice_date DATE,
invoice_total NUMBER(5,2),
 FOREIGN KEY (customer_id) REFERENCES WINMONO_CUSTOMER (customer_id),
 FOREIGN KEY (order_id) REFERENCES WINMONO_ORDER (order_id)); 

--10 table
CREATE TABLE WINMONO_BASKET
(basket_id NUMBER(5),
quantity NUMBER(3,0),
customer_id VARCHAR2(15),
order_placed NUMBER(1), -- 1 - yes, 0 - no
basket_subtotal NUMBER(7,2),
basket_total NUMBER(7,2),
shipping_cost NUMBER(5,2),
tax_amount NUMBER(5,2),
date_created DATE,
discount NUMBER(5,2),
ship_first_name varchar2(50),
ship_last_name varchar2(50),
ship_address varchar2(40),
ship_city varchar2(20),
ship_province varchar2(3),
ship_postal_code varchar2(15),
phone varchar2(10),
email varchar2(50),
bill_first_name varchar2(50),
bill_last_name varchar2(50),
bill_address varchar2(40),
bill_city varchar2(20),
bill_province varchar2(3),
bill_postal_code varchar2(15),
date_ordered DATE,
card_type char(1) , --1 - visa, 2 - master card, 3 - amex, 4 - other
card_number varchar2(20) ,
exp_month char(2),
exp_year char(4),
card_name varchar2(50),
CONSTRAINT WINMONO_BASKET_basket_id_pk PRIMARY KEY(basket_id),
FOREIGN KEY (customer_id) REFERENCES WINMONO_CUSTOMER (customer_id));

-- INSERT DATA

INSERT INTO WINMONO_CATEGORY
VALUES ('1001', 'Wine', 'White Wine, Red Wine, Rose, Porto, Sparkling Wine, Iced Wine, Fruit Wine');
INSERT INTO WINMONO_CATEGORY
VALUES ('1002', 'Beer', 'Lager, Pilsner, Brown Ale, Pale Ale, I.P.A., Porter, Stout');
INSERT INTO WINMONO_CATEGORY
VALUES ('1003', 'Spirits', 'Gin, Vodka, Tequila, Rum, Whisky, Moonshine, Brandy');
INSERT INTO WINMONO_CATEGORY
VALUES ('1004', 'Coolers', 'Hard Seltzer beverages, cocktails');
INSERT INTO WINMONO_CATEGORY
VALUES ('1005', 'Ciders', 'Apple Cider, Pear Cider, Berry Cider'); 


INSERT INTO WINMONO_BRAND
VALUES ('CA1001', 'Trius', 
'Trius Winemaker,Craig McDonald,blends art and science to craft award-winning wines using innovative techniques.This series features wines from Niagara`s best vineyards made with an unrushed approach to winemaking that shines through in every bottle.');
INSERT INTO WINMONO_BRAND
VALUES ('CA1002', 'Moosehead Breweries', 
'Moosehead Breweries Ltd. is the last independent and truly Canadian brewery in Canada.What started as a small one-woman craft brewery,grew with grit throughout time as the commitment to brewing quality beer passed on from generation to generation.');
INSERT INTO WINMONO_BRAND
VALUES ('CA1003', 'Tanqueray', 
'Think of this gin as a tip of the hat to Charles Tanqueray, founder of the nearly two-century-old brand. It honors the man`s perfectionism, which is written all over his recipes and resulting work. Tanqueray didn`t just make spirits worth drinking, he made spirits worth savoring.');
INSERT INTO WINMONO_BRAND
VALUES ('CA1004', 'Vizzy', 
'Vizzy Hard Seltzer was launched by Molson Coors in 2019 and hit the shelves in the U.S. in 2020 with four flavor combinations. The added vitamin C, low-calorie count, and low carbs have made Vizzy an appealing choice for more health-conscious hard seltzer consumers.');
INSERT INTO WINMONO_BRAND
VALUES ('CA1005', 'Strongbow', 
'Strongbow is a dry cider produced by H. P. Bulmer in the United Kingdom since 1960. Strongbow is the world`s leading cider with a 15 per cent volume share of the global cider market and a 29 per cent volume share of the UK cider market.');
INSERT INTO WINMONO_BRAND
VALUES ('CA1006', 'Don Julio', 
'Don Julio is the World`s first luxury tequila. A passion for care, quality and craft defined from day one is the same passion lives on to this day');
INSERT INTO WINMONO_BRAND
VALUES ('CA1007', 'J.Lohr Vineyards and Wines', 
'J. Lohr Vineyards and Wines is dedicated to producing wines that are the finest examples of quality and flavor from each vintage in our chosen appellations of Monterey County, Paso Robles, and Napa Valley. ');
INSERT INTO WINMONO_BRAND
VALUES ('CA1008', 'Marquis De Villard', 
'French brandy, MARQUIS DE VILLARD, has been produced since 1950 following closely the great French traditional methods - brandies are produced in Charente, France; the spirit resulting from the distillation is stored in our cellars, aged in oak barrels; the essences of this wood enrich the unique flavor and impart its golden color.');
INSERT INTO WINMONO_BRAND
VALUES('CA1009', 'Belhaven Brewery', 'Established in 1719, Belhaven Brewery is the oldest working brewery in Scotland. Belhaven is home to the nation`s favourite ales, stouts and lagers: ideal for when people come together over a delicious pint, as good times shared are the BEST.');
INSERT INTO WINMONO_BRAND
VALUES('CA1010', 'Stock and Row', 'Stock and Row began with an idea from two hospitality veterans, Justin and Zoe, to create a low-sugar cider that customers will love. Made with 100% Ontario apples, expect orchard fruit and mineral flavours.');


INSERT INTO WINMONO_PRODUCTS
VALUES ('P0001', 'J. Lohr Seven Oaks Cabernet Sauvignon', '1001', 'CA1007', 750, 'Medium bodied and packed with smoky oak, prune, vanilla with candy and floral hints; equally at home with a casual steak sandwich or a thick rib-eye steak.', 23.95, 98);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0002', 'Trius Sauvignon Blanc VQA', '1001', 'CA1001', 750, 'Pale straw colour; floral, gooseberry and passion fruit aromas with notes of herbs and nuts; extra dry, light-medium body; fresh passion fruit flavour with a long refreshing finish.', 16.95, 150);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0003', 'Moosehead Lager', '1002', 'CA1002', 473, 'Moosehead`s flagship lager pours golden yellow with light hop and grain aromas, along with citrus, cereal and cut grass notes on the palate. Medium-bodied and crisp with a refreshingly balanced finish. ', 2.95, 9);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0004', 'Moosehead Cracked Canoe', '1002', 'CA1002', 473, 'Refreshing and pleasantly flavoured with pale straw colour; delicate aromas of malt, citrus, and hops; light-bodied on the palate; the carbonation is well integrated and leads to a crisp and clean finish.', 2.95, 15);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0005', 'Tanqueray London Dry Gin', '1003', 'CA1003', 750, 'Over 180 years of distilling expertise result in the classic character of Tanqueray. On the nose, juniper is in the foreground, accompanied by citrus and coriander; dry and very balanced, with a hint of sweetness and a reserved, elegant delivery of flavours; the finish is medium in length, with all elements in harmony.', 31.45, 37);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0006', 'Vizzy Hard Seltzer Strawberry Lemonade', '1004', 'CA1004', 473, 
'A crisp and fruity hard seltzer that captures the flavours of summer and includes the addition of superfood Acerola cherries. Made with natural flavours, it displays tart notes of freshly squeezed lemonade combined with the bright, fruity flavours of ripe strawberry.', 3.15, 89);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0007', 'Don Julio Anejo', '1003', 'CA1006', 750, 'Don Julio añejo tequila is a fruit-forward interpretation of the classic añejo style of tequila. Sweet and floral flavors of pear, spice, white pepper, wood and cigar lead to a long and slightly chewy finish.', 107.75, 13);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0008', 'Marquis De Villard Brandy', '1003', 'CA1008', 1140, 
'This brandy is an ode to the warmth she exuded. Fragrant with aromas of sweet cooked apple/pear, vanilla, and caramel with hints of spice; rounded on the palate, with flavours of vanilla, baked fruit, and spice, replaying on the finish.', 44.45, 62);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0009', 'Belhaven Black Scottish Stout', '1002', 'CA1009', 440, 
'Drawing on almost 300 years of brewing experience, Belhaven Black Scottish Stout is a masterpiece of brewing - a deluxe Scottish stout crafted for a dark, deep,flavour which comes from a unique blend of Scottish triple malts which complements the distinctive hop character.', 3.15, 20);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0010', 'Strongbow Cider', '1005', 'CA1005', 500, 
'Clear gold in colour with a thin head; aromas of apple, brown sugar and cinnamon on the nose. The palate is light with lively carbonation and subtle sweetness followed by a short and crisp finish.', 3.40, 31);
INSERT INTO WINMONO_PRODUCTS
VALUES ('P0011', 'Slow and Low Dry Cider', '1005', 'CA1010', 355, 
'Light-bodied and crisp with a clean finish. Pair with pork loin or enjoy as an aperitif. 4g of sugar per 355 mL can.', 3.45, 15);



INSERT INTO WINMONO_CUSTOMER
VALUES ('2201', 'Kyla', 'Zeit', 'k.zeit@protonmail.me', '3760 Merivale Road', 'Ottawa', 'ON', 'K2H 5B6', 'Canada', 6137630373);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2202', 'Theresa ', 'Fry', 't.fry@hotmail.com', '3261 Blanshard Street', 'Victoria', 'BC', 'V8W 2H9', 'Canada', 2503607384);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2203', 'Nathan', 'Potts', 'n.potts@yahoo.ca', '641 Queen Elizabeth Boulevard','Etobicoke', 'ON', 'M8Z 1M3', 'Canada', 6138580469);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2204', 'Alvin', 'Werner', 'a.werner@gmail.com', '870 Brand Road', 'Saskatonn', 'SK', 'S7K 1W8', 'Canada', 3062279288);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2205', 'Molly', 'Kirk', 'm.kirk@yahoo.com', '3726 Boulevard Cremazie', 'Quebec', 'QC', 'G1R 1B8', 'Canada', 6065551234);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2206', 'Lisa Maria', 'Shmidt', 'lisam.shmidt@gmail.com', '15 Cooper Street', 'Toronto', 'ON', 'M5E 0C8', 'Canada', 4168646777);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2207', 'John', 'Dorian', 'dr.acula@hotmail.com', '70 Blackberry Street', 'Kitimat', 'BC', 'V8C 0A6', 'Canada', 2506665588);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2208', 'Erin', 'Best', 'erin_the_best@yahoo.ca', '7737 37 Ave NW','Edmonton', 'AB', 'T6K 1T9', 'Canada', 7804624704);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2209', 'Winnie', 'Pooh', 'winnie-the-pooh@gmail.com', '4 Spence Street', 'Winnipeg', 'MB', 'R3B 2R6', 'Canada', 2047867811);
INSERT INTO WINMONO_CUSTOMER
VALUES ('2210', 'Jack', 'London', 'callwild@yahoo.com', '25 MsLean Lake Road', 'Whitehorse', 'YT', 'Y1A 0M9', 'Canada', 8774583806);


--UPDATE TABLE WINMONO_CUSTOMER WITH CUSTOMER DOB
update winmono_customer
 set birth_date = '15-MAY-1986' where customer_id=2201;
 
 update winmono_customer
 set birth_date = '16-JUN-1988' where customer_id=2202;
 
 update winmono_customer
 set birth_date = '20-AUG-1956' where customer_id=2203;
 
  update winmono_customer
 set birth_date = '01-APR-1985' where customer_id=2204;
 
  update winmono_customer
 set birth_date = '12-SEP-1990' where customer_id=2205;
 
 update winmono_customer
 set birth_date = '18-OCT-1978' where customer_id=2206;
 
  update winmono_customer
 set birth_date = '03-FEB-1995' where customer_id=2207;
 
 update winmono_customer
 set birth_date = '31-MAR-2000' where customer_id=2208;
 
 update winmono_customer
 set birth_date = '04-NOV-1999' where customer_id=2209;
 
 update winmono_customer
 set birth_date = '14-JAN-2001' where customer_id=2210;

INSERT INTO WINMONO_ORDER
VALUES (3001, '2201', '31-MAR-2022', '01-APR-2022', '3760 Merivale Road', 'Ottawa', 'ON', 'K2H 5B6', 'Canada', 240.50, 10.00, 0.13, 260.47, 10);
INSERT INTO WINMONO_ORDER
VALUES (3002, '2207', '03-APR-2022', '10-APR-2022', '70 Blackberry Street', 'Kitimat', 'BC', 'V8C 0A6', 'Canada', 27.2, NULL, 0.12, 30.46, 8);
INSERT INTO WINMONO_ORDER
VALUES (3003, '2202', '21-OCT-2022', '01-NOV-2022', '4514 Carling Avenue', 'Ottawa', 'ON', 'K1Z 7B5', 'Canada', 44.55, NULL, 0.12, 49.90, 1);
INSERT INTO WINMONO_ORDER
VALUES (3004, '2207', '18-MAY-2022', '25-MAY-2022', '70 Blackberry Street', 'Kitimat', 'BC', 'V8C 0A6', 'Canada', 105.00, 5.00, 0.12, 112.00, 30);
INSERT INTO WINMONO_ORDER
VALUES (3005, '2204', '03-NOV-2022', '10-NOV-2022', '870 Brand Road', 'Saskatonn', 'SK', 'S7K 1W8', 'Canada', 239.40, 10.00, 0.11, 254.63, 2);
INSERT INTO WINMONO_ORDER
VALUES (3006, '2205', '11-Jan-2022','15-JAN-2022', '59 rue Levy', 'Montreal', 'QC', 'H3C 5K4', 'Canada', 255.75, 10.00, 0.14975, 282.55, 15);
INSERT INTO WINMONO_ORDER
VALUES (3007, '2206', '13-FEB-2022','14-FEB-2022', '15 Cooper Street', 'Toronto', 'ON', 'M5E 0C8', 'Canada', 109.80, 5.00, 0.13, 118.42, 36);
INSERT INTO WINMONO_ORDER
VALUES (3008, '2208', '08-DEC-2022',NULL,'7737 37 Ave NW','Edmonton', 'AB', 'T6K 1T9', 'Canada', 175.50, 5.00, 0.05, 179.03, 54);
INSERT INTO WINMONO_ORDER
VALUES (3009, '2209', '03-DEC-2022','08-DEC-2022','4 Spence Street', 'Winnipeg', 'MB', 'R3B 2R6', 'Canada', 39.00, NULL, 0.12, 43.68, 12);
INSERT INTO WINMONO_ORDER
VALUES (3010, '2210', '01-MAR-2022','08-MAR-2022','25 MsLean Lake Road', 'Whitehorse', 'YT', 'Y1A 0M9', 'Canada', 356.40, 15.00, 0.05, 358.47, 8);

INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4001', 'P0009', 3002, 4, 0.40);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4002', 'P0011', 3002, 4, 0.40);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4003', 'P0001', 3001, 10, 1.00);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4004', 'P0008', 3003, 1, 0.10);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4005', 'P0010', 3004, 30, 3.00);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4006', 'P0007', 3005, 1, 0.10);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4007', 'P0005', 3005, 1, 0.10);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4008', 'P0002', 3006, 15, 1.50);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4009', 'P0004', 3007, 36, 3.60);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4010', 'P0006', 3008, 54, 5.40);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4011', 'P0009', 3009, 12, 1.20);
INSERT INTO WINMONO_ORDER_ITEMS
VALUES ('WM4012', 'P0008', 3010, 8, 0.80);

INSERT INTO WINMONO_TAX VALUES('T01', 'AB', 'Alberta', 0.05);
INSERT INTO WINMONO_TAX VALUES('T02', 'BC', 'British Columbia', 0.12);
INSERT INTO WINMONO_TAX VALUES('T03', 'MB', 'Manitoba', 0.12);
INSERT INTO WINMONO_TAX VALUES('T04', 'NB', 'New Brunswick', 0.15);
INSERT INTO WINMONO_TAX VALUES('T05', 'NL', 'Newfoundland and Labrador', 0.15);
INSERT INTO WINMONO_TAX VALUES('T06', 'NWT', 'Northwest Territories', 0.05);
INSERT INTO WINMONO_TAX VALUES('T07', 'NS', 'Nova Scotia', 0.15);
INSERT INTO WINMONO_TAX VALUES('T08', 'NU', 'NNunavut', 0.05);
INSERT INTO WINMONO_TAX VALUES('T09', 'ON', 'Ontario', 0.13);
INSERT INTO WINMONO_TAX VALUES('T10', 'PE', 'Prince Edward Island', 0.15);
INSERT INTO WINMONO_TAX VALUES('T11', 'QC', 'Quebec', 0.14975);
INSERT INTO WINMONO_TAX VALUES('T12', 'SK', 'Saskatchewan', 0.11);
INSERT INTO WINMONO_TAX VALUES('T13', 'YT', 'Yukon', 0.05);

INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP01', 750, 0.20);
INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP02', 500, 0.10);
INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP03', 473, 0.10);
INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP04', 440, 0.10);
INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP05', 355, 0.10);
INSERT INTO WINMONO_BOTTLE_DEPOSIT VALUES ('DEP06', 1140, 0.20);

INSERT INTO WINMONO_INVOICE
VALUES (20220001, 3001, '2201', '31-MAR-2022', '01-APR-2022', '01-APR-2022', 260.47);
INSERT INTO WINMONO_INVOICE
VALUES (20220002, 3002, '2207', '03-APR-2022', '10-APR-2022', '10-APR-2022', 30.46);
INSERT INTO WINMONO_INVOICE
VALUES (20220003, 3003, '2202', '21-OCT-2022', '01-NOV-2022', '03-NOV-2022', 49.90);
INSERT INTO WINMONO_INVOICE
VALUES (20220004, 3004, '2207', '18-MAY-2022', '25-MAY-2022', '27-MAY-2022', 112.00);
INSERT INTO WINMONO_INVOICE
VALUES (20220005, 3005, '2204', '03-NOV-2022', '10-NOV-2022', '11-NOV-2022', 254.63);
INSERT INTO WINMONO_INVOICE 
VALUES (20220006, 3006, '2205', '11-Jan-2022','15-JAN-2022', '16-JAN-2022', 282.55);
INSERT INTO WINMONO_INVOICE
VALUES (20220007, 3007, '2206', '13-FEB-2022','14-FEB-2022', '16-FEB-2022', 118.42);
INSERT INTO WINMONO_INVOICE
VALUES (20220008, 3008, '2208', '08-DEC-2022', NULL, '09-DEC-2022', 179.03);
INSERT INTO WINMONO_INVOICE
VALUES (20220009, 3009, '2209', '03-DEC-2022','08-DEC-2022', '09-DEC-2022', 43.68);
INSERT INTO WINMONO_INVOICE
VALUES (20220010, 3010, '2210', '01-MAR-2022','08-MAR-2022', '08-MAR-2022', 358.47);


INSERT INTO WINMONO_BASKET
VALUES (10001, 10, '2201', 1, 240.5, 260.47, NULL, 29.97, '31-MAR-2022', 10.00, 'Kyla', 'Zeit', '3760 Merivale Road', 'Ottawa', 'ON', 'K2H 5B6', 6137630373, 'k.zeit@protonmail.me', 'Kyla', 'Zeit',  '3760 Merivale Road', 'Ottawa', 'ON', 'K2H 5B6', '31-MAR-2022', '1', '2222 5555 3333 4444', '02', '2026', 'Kyla Zeit');
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10002, 15, '2203', 0, 48.75);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10003, 2, '2204', 0, 89.30);
INSERT INTO WINMONO_BASKET
VALUES (10004, 1, '2202', 1, 44.55, 49.90, 13.99, 5.40, '21-OCT-2022', NULL, 'Theresa ', 'Fry', '4514 Carling Avenue', 'Ottawa', 'ON', 'K1Z 7B5', 2503607384, 't.fry@hotmail.com', 'Theresa', 'Fry', '3261 Blanshard Street', 'Victoria', 'BC', 'V8W 2H9', '21-OCT-2022', '2', '1001 2002 3003 4004', '06', '2023', 'Theresa Fry');
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10005, 10, '2205', 0, 171.50);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10006, 30, '2206', 0, 97.50);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10007, 15, '2207', 0, 53.25);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10008, 2, '2208', 0, 63.30);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10009, 1, '2209', 0, 44.75);
INSERT INTO WINMONO_BASKET(basket_id, quantity, customer_id, order_placed, basket_subtotal) VALUES (10010, 1, '2210', 0, 107.95);