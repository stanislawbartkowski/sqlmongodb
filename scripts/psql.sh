source ./proc/psqlproc.sh

testconn() {
   psqlcommand "\dt"
}

executescript() {
    if grep 'CREATE TABLE' $1; then
      local TM=`crtemp`
      sed 's/blob/bytea/g' $1 >$TM
      psqlscript $TM
    else
        psqlscript $1;
    fi
}

