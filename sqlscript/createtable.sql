CREATE TABLE customers (
  customerNumber integer NOT NULL,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber integer DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber)
  );

CREATE TABLE employees (
  employeeNumber integer NOT NULL,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo integer DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber)
) ;

CREATE TABLE offices (
  officeCode varchar(10) NOT NULL,
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
) ;

CREATE TABLE orderdetails (
  orderNumber integer NOT NULL,
  productCode varchar(15) NOT NULL,
  quantityOrdered integer NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint NOT NULL,
  PRIMARY KEY (orderNumber,productCode)
) ;

CREATE TABLE orders (
  orderNumber integer NOT NULL,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments varchar(4000),
  customerNumber integer NOT NULL,
  PRIMARY KEY (orderNumber)
) ;

CREATE TABLE payments (
  customerNumber integer NOT NULL,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber)
) ;

CREATE TABLE productlines (
  productLine varchar(50) NOT NULL,
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription varchar(4000),
  image blob,
  PRIMARY KEY (productLine)
) ;

CREATE TABLE products (
  productCode varchar(15) NOT NULL,
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription varchar(4000) NOT NULL,
  quantityInStock smallint NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode)
) ;

