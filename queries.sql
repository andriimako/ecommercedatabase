-- 1. Select all the data about the products which manufacturer is Manufacturer 2 and supplier is Supplier 1. Order the result in descending order by name.

select * from PRODUCT
where MANUFACTURER='Manufacturer 2' and Supplier='Supplier 1'
order by name desc;

-- 2. Sum up the total price of all products in Category 1 along with its name;

select sum(PRODUCT.QAVAILABLE*PRICE) TotalPRICEofASSETS, PRODUCT.NAME from PRODUCT
join PRODUCTCATEGORY PC on PC.PRODUCTCATEGORY_ID = PRODUCT.PRODUCTCATEGORY_ID
where PC.NAME = 'Category 1'
group by PRODUCT.NAME;

-- 3. Select products where there is no review

select * from PRODUCT
where not exists (select * from REVIEW where REVIEW.PRODUCT_ID=PRODUCT.PRODUCT_ID);

-- 4. Count the number of customers who bought Product 1

select count('x') buyersOfProduct1 from CUSTOMER
join "Order" O on CUSTOMER.CUSTOMER_ID = O.CUSTOMER_ID
join PRODUCTINORDER PIO on O.ORDER_ID = PIO.ORDER_ID
join PRODUCT P on PIO.PRODUCT_ID = P.PRODUCT_ID
where P.NAME='Product 1';

-- 5. List the categories of the products that customer from Uganda buy

select distinct PRODUCTCATEGORY.NAME from PRODUCTCATEGORY
join PRODUCT P on PRODUCTCATEGORY.PRODUCTCATEGORY_ID = P.PRODUCTCATEGORY_ID
join PRODUCTINORDER P2 on P.PRODUCT_ID = P2.PRODUCT_ID
join "Order" O on O.ORDER_ID = P2.ORDER_ID
join ADDRESS A on O.ADDRESS_ID = A.ADDRESS_ID
join ORDERINSATUS O2 on O.ORDER_ID = O2.ORDER_ID
join ORDERSTATUS O3 on O3.ORDERSTATUS_ID = O2.ORDERSTATUS_ID
where A.COUNTRY = 'Uganda' and O3.STATUS = 'Completed';

-- 6. Select the name of the product which has the highest price

select NAME, PRICE from PRODUCT
where PRICE=(select max(PRICE) from PRODUCT);

-- 7. Select the average price of a product in Category 1

select PRODUCTCATEGORY.*, (select avg(PRICE) from PRODUCT where PRODUCT.PRODUCTCATEGORY_ID=PRODUCTCATEGORY.PRODUCTCATEGORY_ID) AveragePrice from PRODUCTCATEGORY
where NAME = 'Category 1';

-- 8. Get the list of the users alongside their addresses and customer info, even if the user doesn't have an address we need to have them in the list

select * from "User"
left join CUSTOMER on "User".USER_ID = CUSTOMER.CUSTOMER_ID
left join ADDRESS on "User".USER_ID = ADDRESS.USER_ID;



-- INSERT QUERIES

-- Products  && Categories

insert into PRODUCTCATEGORY (PRODUCTCATEGORY_ID, NAME, DESCRIPTION)
VALUES (1, 'Category 1', 'Description');

insert into PRODUCT (PRODUCT_ID, PRODUCTCATEGORY_ID, NAME, DESCRIPTION, MANUFACTURER, SUPPLIER, QAVAILABLE, PRICE, DISCOUNT)
VALUES (1, 1, 'Product 1', 'Description 1', 'Manufacturer 2', 'Supplier 1', 1, 10, null);

insert into PRODUCT (PRODUCT_ID, PRODUCTCATEGORY_ID, NAME, DESCRIPTION, MANUFACTURER, SUPPLIER, QAVAILABLE, PRICE, DISCOUNT)
VALUES (2, 1, 'Product 2', 'Description 2', 'Manufacturer 2', 'Supplier 2', 2, 20, null);

-- Payment types

INSERT INTO PAYMENTTYPE (PAYMENTTYPE_ID, NAME)
VALUES (1, 'Credit card');

INSERT INTO PAYMENTTYPE (PAYMENTTYPE_ID, NAME)
VALUES (2, 'Credit card on delivery');

INSERT INTO PAYMENTTYPE (PAYMENTTYPE_ID, NAME)
VALUES (3, 'PayPal');

INSERT INTO PAYMENTTYPE (PAYMENTTYPE_ID, NAME)
VALUES (4, 'Cash');

-- Order statuses

INSERT INTO ORDERSTATUS (ORDERSTATUS_ID, STATUS)
VALUES (1, 'Active');

INSERT INTO ORDERSTATUS (ORDERSTATUS_ID, STATUS)
VALUES (2, 'Completed');

INSERT INTO ORDERSTATUS (ORDERSTATUS_ID, STATUS)
VALUES (3, 'Cancelled');

-- 1st customer/user and order

insert into CUSTOMER (CUSTOMER_ID, NAME, SURNAME, EMAIL, PHONE)
VALUES  (1, 'Ovuveveve Onyetveveve', 'Ogemugwem Osas', 'email@email.com','123123123');

insert into "User" (USER_ID, LOGIN, PASSWORD, DISCOUNT, GENDER, BIRTHDATE)
VALUES (1, 'email@email.com', 'password1', null, 'transgenda', TO_DATE('2010-02-04', 'YYYY-MM-DD')); -- TO_DATE( ,'YYYY-MM-DD')

insert into ADDRESS (ADDRESS_ID, COUNTRY, CITY, STREET, APARTMENT, POSTCODE, USER_ID)
VALUES (1, 'Ukraine', 'Moscow', 'Wall Street 7', 420, '666', 1);


insert into USERSESSION (USERSESSION_ID, IP, TIMESTAMP, CUSTOMER_ID)
VALUES (1,'192.168.420.666', TO_TIMESTAMP('2021-02-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 1); -- TO_TIMESTAMP(:ts_val, 'YYYY-MM-DD HH24:MI:SS')

insert into "Order" (ORDER_ID, CUSTOMER_ID, ADDRESS_ID, PAYMENTTYPE_ID, SHIPPINGDATE, ORDERTIME, PAYMENTTIME)
VALUES (1, 1, 1, 1, TO_DATE('2021-02-05','YYYY-MM-DD'), TO_TIMESTAMP('2021-02-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'),  TO_TIMESTAMP('2021-02-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into ORDERINSATUS (ORDERINSTATUS_ID, ORDERSTATUS_ID, ORDER_ID, DATEFROM, DATETO)
VALUES  (1, 1, 1, TO_TIMESTAMP('2021-02-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2021-02-05 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into PRODUCTINORDER (PRODUCTINORDER_ID, ORDER_ID, PRODUCT_ID, AMOUNT, TIMEADDED)
VALUES (1, 1, 1, 1, TO_TIMESTAMP('2021-02-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into PRODUCTINORDER (PRODUCTINORDER_ID, ORDER_ID, PRODUCT_ID, AMOUNT, TIMEADDED)
VALUES (2, 1, 2, 3, TO_TIMESTAMP('2021-02-04 23:20:59', 'YYYY-MM-DD HH24:MI:SS'));


-- 2nd user

insert into CUSTOMER (CUSTOMER_ID, NAME, SURNAME, EMAIL, PHONE)
VALUES  (3, 'lolol', 'oy vey', 'mossad@gov.co.il','123123123');

insert into "User" (USER_ID, LOGIN, PASSWORD, DISCOUNT, GENDER, BIRTHDATE)
VALUES (2, 'mossad@gov.co.il', 'password123', null, 'unknown', TO_DATE('1913-02-04', 'YYYY-MM-DD')); -- TO_DATE( ,'YYYY-MM-DD')

-- 3rd customer and order

insert into CUSTOMER (CUSTOMER_ID, NAME, SURNAME, EMAIL, PHONE)
VALUES  (2, 'Name 2', 'Surname 2', 'email2@email.com','123456789');

insert into ADDRESS (ADDRESS_ID, COUNTRY, CITY, STREET, APARTMENT, POSTCODE, USER_ID)
VALUES (2, 'Uganda', 'New York', 'Osas Street 228', 666, '420', null);

insert into "Order" (ORDER_ID, CUSTOMER_ID, ADDRESS_ID, PAYMENTTYPE_ID, SHIPPINGDATE, ORDERTIME, PAYMENTTIME)
VALUES (2, 2, 2, 1, TO_DATE('2021-01-05','YYYY-MM-DD'), TO_TIMESTAMP('2021-01-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'),  TO_TIMESTAMP('2021-01-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into ORDERINSATUS (ORDERINSTATUS_ID, ORDERSTATUS_ID, ORDER_ID, DATEFROM, DATETO)
VALUES  (2, 2, 2, TO_TIMESTAMP('2021-01-04 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2021-01-05 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into PRODUCTINORDER (PRODUCTINORDER_ID, ORDER_ID, PRODUCT_ID, AMOUNT, TIMEADDED)
VALUES (3, 2, 2, 4, TO_TIMESTAMP('2021-02-04 22:59:59', 'YYYY-MM-DD HH24:MI:SS'));

insert into PRODUCTINORDER (PRODUCTINORDER_ID, ORDER_ID, PRODUCT_ID, AMOUNT, TIMEADDED)
VALUES (4, 2, 1, 3, TO_TIMESTAMP('2021-02-04 23:20:59', 'YYYY-MM-DD HH24:MI:SS'));

--4th customer

insert into CUSTOMER (CUSTOMER_ID, NAME, SURNAME, EMAIL, PHONE)
VALUES  (4, 'Moyshe', 'Katzman', 'm.catzman@gov.co.il','420420420');

-- 5th customer

insert into CUSTOMER (CUSTOMER_ID, NAME, SURNAME, EMAIL, PHONE)
VALUES  (5, 'Muhammad', 'Abdallah', 'm.abdallah@protonmail.ch','06565656');

-- Delete and update queries

DELETE FROM CUSTOMER
where NAME='Muhammad';

UPDATE CUSTOMER
    SET PHONE = '228228228'
    where NAME = 'Moyshe';

commit;
