source ./proc/db2commonproc.sh

testconn() {
    db2connect
    db2terminate
}

executescript() {
    db2runscript $1
}


required_listofcommands db2
required_listofvars DBUSER DBPASSWORD DB

DBNAME=$DB

