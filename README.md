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
| DBUSER | Database user authorized to insert data into database | queryuser
| DBPASSWORD | Password for DBUSER | secret
| DB | Database | querydb




