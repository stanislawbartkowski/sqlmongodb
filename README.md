# sqlmongodb

https://www.mysqltutorial.org/mysql-sample-database.aspx

# Files description

| File | Content |
| ---- | ------- |
| sqlscript/createtables.sql  | DDL to create table, keys and primary keys 
| sqlscript/droptable.sql | Drop all tables, clear
| sqlscript/addconstraints.sql | DDL to create foreign keys
| insert/table_name/.sql | SQL script inserting the data. For instance: insertcustomers.sql : insert rows into *customers* table

# Configure

> cp template/resource.rc resource.rc<br>
> vi resource.rc<br>

| Parameter | Description | Example
| ---- | ---- | ---- |
| DBTYPE | Database type | mysql 
| DBHOST | Database hostname | kist
| DBUSER | Database user authorized to insert data into database  *DB* | queryuser
| DBPASSWORD | Password for *DBUSER* | secret
| DB | Database name | querydb

# Insert data into MySQL database

## Create database

> create database querydb;<br>
> CREATE USER 'queryuser'@'%' IDENTIFIED BY 'secret';<br>
> GRANT ALL PRIVILEGES ON querydb.* TO 'queryuser'@'%';<br>


## Configure access data

> vi resource.rc<br>

| Parameter | Value
| --- | ---- |
| DBTYPE | mysql 
| DBHOST | kist
| DBUSER | queryuser
| DBPASSWORD | secret
| DB | querydb

## Test connection

> vi run.sh<br>

Uncomment.
```
main test
```
> ./run.sh
```
Test mysql connection
mysql: [Warning] Using a password on the command line interface can be insecure.
OK

```

## Create database schema
> vi run.sh<br>

Uncomment
```
main create
```

> ./run.sh
```
Create tables
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Create constraints
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.

```
## Load data
> vi run.sh<br>

Uncomment
```
main insert
```

> ./run.sh
```
Insert offices
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert employees
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert customers
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert orders
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert productlines
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert products
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert orderdetails
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.
Insert payments
Host: kist User: queryuser Database: querydb
mysql: [Warning] Using a password on the command line interface can be insecure.

```

# Insert into PostreSQL database

## Create user and database

> CREATE USER queryuser WITH PASSWORD 'secret';<br>
> create database querydb with owner queryuser;<br>

## Configure access 

> vi resource.rc<br>

| Parameter | Value
| --- | ---- |
| DBTYPE | psql
| DBHOST | kist
| DBUSER | queryuser
| DBPASSWORD | secret
| DB | querydb

## Test connection

> vi run.sh<br>

Uncomment.
```
main test
```
> ./run.sh
```
Test psql connection
Did not find any relations.
OK
```

## Create tables

> vi run.sh<br>

Uncomment
```
main create
```

> ./run.sh
```
Create tables
CREATE TABLE customers (
CREATE TABLE employees (
CREATE TABLE offices (
CREATE TABLE orderdetails (
CREATE TABLE orders (
CREATE TABLE payments (
CREATE TABLE productlines (
CREATE TABLE products (
CREATE TABLE
CREATE TABLE
CREATE TABLE
...
Create constraints
ALTER TABLE
ALTER TABLE
....
CREATE INDEX
CREATE INDEX
...
```
## Load data
> vi run.sh<br>

Uncomment
```
main insert
```

> ./run.sh
```
Insert offices
INSERT 0 7
Insert employees
INSERT 0 23
Insert customers
INSERT 0 122
Insert orders
INSERT 0 326
Insert productlines
INSERT 0 7
Insert products
INSERT 0 110
Insert orderdetails
INSERT 0 2996
Insert payments
INSERT 0 273
```

# Insert data into DB2 database

## Catalog

Catalog DB2 database using *db2* command line. Example

> db2 catalog tcpip node db2cont remote thinkde server 50000<br>
> db2 catalog database querydb at node db2cont<br>

## Configure

> vi resource.rc<br>

| Parameter | Description | Sample
| ---- | ----- | ---- |
| DBTYPE | db2 |
| DBUSER | Database user name | db2inst1
| DBPASSWORD | Password | secret
| DB | Database name | querydb

## Create schema and insert data

> vi run.sh<br>
```
main test
main drop
main create
main insert
```
> ./run.sh

# Insert data into MongoDB collection

## Export data to CSV

It is done already, data is exported to *export* directory.

Configure access to MySQL database in *resource.rc* file.<br>

Export data

> vi run.sh<br>

Uncomment
```
main export

```

> ./run.sh
```
Export offices to export/offices.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export employees to export/employees.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export customers to export/customers.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export orders to export/orders.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export productlines to export/productlines.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export products to export/products.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export orderdetails to export/orderdetails.csv
mysql: [Warning] Using a password on the command line interface can be insecure.
Export payments to export/payments.csv
mysql: [Warning] Using a password on the command line interface can be insecure.

```

## Create MongoDB database

As cluster *userAdmin* create the user having *userAdmin* role in *querydb* database. It is the only moment where *clusterAdmin* authority is required.

>  mongo mongodb://userAdmin:c5xgfwVZwfS4u66r@kist  --authenticationDatabase 'admin'<br>
>  use querydb<br>
>  db.createUser( { user: 'userAdmin', pwd: 'secret', roles: [ { role: 'userAdmin', db: 'querydb' } ] } );<br>

As *querydb* *userAdmin* create *dbOwner* role in *querydb* database.

> mongo mongodb://userAdmin:secret@kist/querydb --authenticationDatabase 'querydb'<br>
> use querydb<br>
> db.createUser( { user: 'dbOwner', pwd: 'secret', roles: [ { role: 'dbOwner', db: 'querydb' } ] } );

## Configure MongoDB access 

> vi resource.rc<br>

| Parameter | Description | Example
| ---- | ----- | ----- |
| MONGOURI | Connection string  | mongodb://dbOwner:secret@kist/querydb
| MONGODB |  MongoDB database | querydb

> vi run.sh<br>

Uncomment
```
main importmongo

```
>./run.sh<br>
```
Import export/offices.csv
2021-08-16T20:23:10.879+0200	using write concern: &{majority false 0}
2021-08-16T20:23:10.879+0200	using 8 decoding workers
2021-08-16T20:23:10.879+0200	using 1 insert workers
2021-08-16T20:23:10.880+0200	will listen for SIGTERM, SIGINT, and SIGKILL
2021-08-16T20:23:12.122+0200	reading from stdin
2021-08-16T20:23:12.122+0200	using fields: officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory
2021-08-16T20:23:12.122+0200	connected to: mongodb://[**REDACTED**]@kist/querydb
2021-08-16T20:23:12.123+0200	ns: querydb.offices
2021-08-16T20:23:12.322+0200	connected to node type: mongos

................
```
