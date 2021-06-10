ALTER TABLE customers ADD CONSTRAINT customers_ibfk_1 FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber);

ALTER TABLE employees ADD CONSTRAINT employees_ibfk_1 FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber);
ALTER TABLE employees ADD CONSTRAINT employees_ibfk_2 FOREIGN KEY (officeCode) REFERENCES offices (officeCode);

ALTER TABLE orderdetails ADD CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber);
ALTER TABLE orderdetails ADD CONSTRAINT orderdetails_ibfk_2 FOREIGN KEY (productCode) REFERENCES products (productCode);

ALTER TABLE payments ADD CONSTRAINT payments_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE products ADD CONSTRAINT products_ibfk_1 FOREIGN KEY (productLine) REFERENCES productlines (productLine);

ALTER TABLE orders ADD CONSTRAINT orders_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);