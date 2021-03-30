-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-02-03 23:19:16.757

-- tables
-- Table: Address
CREATE TABLE Address (
    Address_ID integer  NOT NULL,
    Country varchar2(100)  NOT NULL,
    City varchar2(100)  NOT NULL,
    Street varchar2(250)  NOT NULL,
    Apartment integer  NOT NULL,
    PostCode varchar2(20)  NOT NULL,
    User_ID integer  NULL,
    CONSTRAINT Address_pk PRIMARY KEY (Address_ID)
) ;

-- Table: Customer
CREATE TABLE Customer (
    Customer_ID integer  NOT NULL,
    Name varchar2(40)  NOT NULL,
    Surname varchar2(100)  NOT NULL,
    Email varchar2(250)  NOT NULL,
    Phone varchar2(100)  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (Customer_ID)
) ;

-- Table: Order
CREATE TABLE "Order" (
    Order_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    Address_ID integer  NOT NULL,
    PaymentType_ID integer  NOT NULL,
    ShippingDate date  NOT NULL,
    OrderTime timestamp  NOT NULL,
    PaymentTime timestamp  NOT NULL,
    CONSTRAINT Order_pk PRIMARY KEY (Order_ID)
) ;

-- Table: OrderInSatus
CREATE TABLE OrderInSatus (
    OrderInStatus_ID integer  NOT NULL,
    OrderStatus_ID integer  NOT NULL,
    Order_ID integer  NOT NULL,
    DateFrom timestamp  NOT NULL,
    DateTo timestamp  NULL,
    CONSTRAINT OrderInSatus_pk PRIMARY KEY (OrderInStatus_ID)
) ;

-- Table: OrderStatus
CREATE TABLE OrderStatus (
    OrderStatus_ID integer  NOT NULL,
    Status varchar2(20)  NOT NULL,
    CONSTRAINT OrderStatus_pk PRIMARY KEY (OrderStatus_ID)
) ;

-- Table: PaymentType
CREATE TABLE PaymentType (
    PaymentType_ID integer  NOT NULL,
    Name varchar2(200)  NOT NULL,
    CONSTRAINT PaymentType_pk PRIMARY KEY (PaymentType_ID)
) ;

-- Table: Product
CREATE TABLE Product (
    Product_ID integer  NOT NULL,
    ProductCategory_ID integer  NOT NULL,
    Name varchar2(250)  NOT NULL,
    Description varchar2(500)  NOT NULL,
    Manufacturer varchar2(250)  NOT NULL,
    Supplier varchar2(100)  NOT NULL,
    QAvailable integer  NULL,
    Price integer  NOT NULL,
    Discount integer  NULL,
    CONSTRAINT Product_pk PRIMARY KEY (Product_ID)
) ;

-- Table: ProductCategory
CREATE TABLE ProductCategory (
    ProductCategory_ID integer  NOT NULL,
    Name varchar2(100)  NOT NULL,
    Description varchar2(500)  NOT NULL,
    CONSTRAINT ProductCategory_pk PRIMARY KEY (ProductCategory_ID)
) ;

-- Table: ProductInOrder
CREATE TABLE ProductInOrder (
    ProductInOrder_ID integer  NOT NULL,
    Order_ID integer  NOT NULL,
    Product_ID integer  NOT NULL,
    Amount integer  NOT NULL,
    TimeAdded timestamp  NOT NULL,
    CONSTRAINT ProductInOrder_pk PRIMARY KEY (ProductInOrder_ID)
) ;

-- Table: Review
CREATE TABLE Review (
    Review_ID integer  NOT NULL,
    User_ID integer  NOT NULL,
    Product_ID integer  NOT NULL,
    Text varchar2(1000)  NOT NULL,
    DateTime timestamp  NOT NULL,
    CONSTRAINT Review_pk PRIMARY KEY (Review_ID)
) ;

-- Table: User
CREATE TABLE "User" (
    User_ID integer  NOT NULL,
    Login varchar2(250)  NOT NULL,
    Password varchar2(250)  NOT NULL,
    Discount integer  NULL,
    Gender varchar2(10)  NOT NULL,
    Birthdate date  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (User_ID)
) ;

-- Table: UserSession
CREATE TABLE UserSession (
    UserSession_ID integer  NOT NULL,
    IP varchar2(50)  NOT NULL,
    Timestamp timestamp  NOT NULL,
    Customer_ID integer  NOT NULL,
    CONSTRAINT UserSession_pk PRIMARY KEY (UserSession_ID)
) ;

-- foreign keys
-- Reference: Address_User (table: Address)
ALTER TABLE Address ADD CONSTRAINT Address_User
    FOREIGN KEY (User_ID)
    REFERENCES "User" (User_ID);

-- Reference: Order_Address (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Address
    FOREIGN KEY (Address_ID)
    REFERENCES Address (Address_ID);

-- Reference: Order_Customer (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (Customer_ID);

-- Reference: Order_Payment (table: Order)
ALTER TABLE "Order" ADD CONSTRAINT Order_Payment
    FOREIGN KEY (PaymentType_ID)
    REFERENCES PaymentType (PaymentType_ID);

-- Reference: ProductInCart_Product (table: ProductInOrder)
ALTER TABLE ProductInOrder ADD CONSTRAINT ProductInCart_Product
    FOREIGN KEY (Product_ID)
    REFERENCES Product (Product_ID);

-- Reference: ProductInOrder_Order (table: ProductInOrder)
ALTER TABLE ProductInOrder ADD CONSTRAINT ProductInOrder_Order
    FOREIGN KEY (Order_ID)
    REFERENCES "Order" (Order_ID);

-- Reference: Product_ProductCategory (table: Product)
ALTER TABLE Product ADD CONSTRAINT Product_ProductCategory
    FOREIGN KEY (ProductCategory_ID)
    REFERENCES ProductCategory (ProductCategory_ID);

-- Reference: Review_Product (table: Review)
ALTER TABLE Review ADD CONSTRAINT Review_Product
    FOREIGN KEY (Product_ID)
    REFERENCES Product (Product_ID);

-- Reference: Review_User (table: Review)
ALTER TABLE Review ADD CONSTRAINT Review_User
    FOREIGN KEY (User_ID)
    REFERENCES "User" (User_ID);

-- Reference: Table_17_Order (table: OrderInSatus)
ALTER TABLE OrderInSatus ADD CONSTRAINT Table_17_Order
    FOREIGN KEY (Order_ID)
    REFERENCES "Order" (Order_ID);

-- Reference: Table_17_OrderStatus (table: OrderInSatus)
ALTER TABLE OrderInSatus ADD CONSTRAINT Table_17_OrderStatus
    FOREIGN KEY (OrderStatus_ID)
    REFERENCES OrderStatus (OrderStatus_ID);

-- Reference: UserSession_Customer (table: UserSession)
ALTER TABLE UserSession ADD CONSTRAINT UserSession_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (Customer_ID);

-- Reference: User_Customer (table: User)
ALTER TABLE "User" ADD CONSTRAINT User_Customer
    FOREIGN KEY (User_ID)
    REFERENCES Customer (Customer_ID);

-- End of file.

