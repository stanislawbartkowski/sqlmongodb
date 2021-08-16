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

As *querydb* *userAdmin* create *dbAdmin* role in *querydb* database.

> mongo mongodb://userAdmin:secret@kist/querydb --authenticationDatabase 'querydb'<br>
> use querydb<br>
> db.createUser( { user: 'dbAdmin', pwd: 'secret', roles: [ { role: 'dbAdmin', db: 'querydb' } ] } );

## Configure MongoDB access 

> vi resource.rc<br>

| Parameter | Description | Example
| ---- | ----- | ----- |
| MONGOURI | Connection string  | mongodb://dbAdmin:secret@kist/querydb
| MONGODB |  MongoDB database | querydb
