# sqlmongodb

https://www.mysqltutorial.org/mysql-sample-database.aspx

# Load data into MySQL

Remove *classicmodels* if exists.

> drop database classicmodels;<br>
<br>


Load sample data.<br>

>mysql -h /<host name/> kist -u root -p <db.orig/mysqlsampledatabase.sql <br>

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

## Create database.

> create database querydb;<br>
> CREATE USER 'queryuser'@'%' IDENTIFIED BY 'secret';<br>
> GRANT ALL PRIVILEGES ON querydb.* TO 'queryuser'@'%';<br>


## Configure access data.

> vi resource.rc<br>

| Parameter | Value
| --- | ---- |
| DBTYPE | mysql 
| DBHOST | kist
| DBUSER | queryuser
| DBPASSWORD | secret
| DB | querydb

## Test connection.

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

## Create database schema.
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
