source ./proc/mysqlproc.sh

testconn() {
    mysqlcommand quit
}

executescript() {
    mysqlscript $1
}

exporttable() {
    mysqlexporttable $1 $2
}