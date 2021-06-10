source ./resource.rc
source ./proc/commonproc.sh
touchlogfile
required_var DBTYPE
usetemp
source ./scripts/$DBTYPE.sh

importmongo() {
    local -r table=$1
    shift
    log "Import $EXPDIR/$table.csv"
    cat $EXPDIR/$table.csv | tr "|" "\t" | mongoimport --type tsv --db=$MONGODB --collection=$table --ignoreBlanks --uri=$MONGOURI --drop  -v --mode insert $@
    [ $? -ne 0 ] && logfail "Failed while importing mongo collection $table"
}

printhelp() {
    echo "Parameters: test drop create insert importmongo"
}

testconnection() {
   log "Test $DBTYPE connection"    
   testconn
   [ $? -eq 0 ] || logfail "Cannot connect to database"
   log "OK"
}

droptables() {
    log "Dropping tables"
    executescript sqlscript/droptables.sql
    [ $? -eq 0 ] || logfail "Dropping tables failed"
    log "OK"
}

inserttable() {
    local -r script=$1
    local -r mess=$2
    log "Insert $mess"
    executescript sqlscript/$script
    [ $? -eq 0 ] || logfail "Inserting $mess failed"
}

createtables() {
    log "Create tables"
    executescript sqlscript/createtable.sql 
    [ $? -eq 0 ] || logfail "Creating tables failed"
    log "Create constraints"
    executescript sqlscript/addconstraints.sql
    [ $? -eq 0 ] || logfail "Creating constraints failed"
}

insertdata() {
    inserttable insertoffices.sql offices
    inserttable insertemployees.sql employees
    inserttable insertcustomers.sql customers
    inserttable insertorders.sql orders
    inserttable insertproductlines.sql productlines
    inserttable insertproducts.sql  products
    inserttable insertorderdetails.sql orderdetails
    inserttable insertpayments.sql payments
}

etable() {
   local -t table=$1
   local -r ETABLE=$EXPDIR/$table.csv
   log "Export $table to $ETABLE"
   exporttable $1 $ETABLE
   [ $? -eq 0 ] || logfail "Exporting table to csv failed"
}

exporttables() {
    required_var EXPDIR
    mkdir -p $EXPDIR
    etable offices
    etable employees
    etable customers
    etable orders
    etable productlines
    etable products
    etable orderdetails
    etable payments
}

importmongoall() {
    required_listofvars MONGOURI MONGODB EXPDIR

    importmongo offices --columnsHaveTypes --fields="officeCode.int32(),city.string(),phone.string(),addressLine1.string(),addressLine2.string(),state.string(),country.string(),postalCode.string(),territory.string()"
    importmongo customers --columnsHaveTypes --fields="customerNumber.int32(),customerName.string(),contactLastName.string(),contactFirstName.string(),phone.string(),addressLine1.string(),addressLine2.string(),city.string(),state.string(),postalCode.string(),country.string(),salesRepEmployeeNumber.int32(),creditLimit.decimal()"
    importmongo employees --columnsHaveTypes --fields="employeeNumber.int32(),lastName.string(),firstName.string(),extension.string(),email.string(),officeCode.string(),reportsTo.int32(),jobTitle.string()"
    importmongo orders --columnsHaveTypes --fields="orderNumber.int32(),orderDate.date(2006-01-02),requiredDate.date(2006-01-02),shippedDate.date(2006-01-02),status.string(),comments.string(),customerNumber.int32()"

    importmongo productlines --columnsHaveTypes --fields="productLine.string(),textDescription.string(),htmlDescription.string(),image.string()"
    importmongo products --columnsHaveTypes --fields="productCode.string(),productName.string(),productLine.string(),productScale.string(),productVendor.string(),productDescription.string(),quantityInStock.int32(),buyPrice.decimal(),MSRP.decimal()"
    importmongo orderdetails --columnsHaveTypes --fields="orderNumber.int32(),productCode.string(),quantityOrdered.int32(),priceEach.decimal(),orderLineNumber.int32()"
    importmongo payments --columnsHaveTypes --fields="customerNumber.int32(),checkNumber.string(),paymentDate.date(2006-01-02),amount.decimal()"

}

main() {
  case $1 in
    test) testconnection;;
    drop) droptables;;
    create) createtables;;
    insert) insertdata;;
    export) exporttables;;
    importmongo) importmongoall;;
    *) printhelp; logfail "Parameter expected";;
  esac
}

