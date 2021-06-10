function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s) { return rtrim(ltrim(s)); }

BEGIN {
  FS="|"
}

{
  for(i = 2; i <= NF; i++) {
     if (i > 2) printf("|");
     s = trim($i)
     if (s != "NULL") printf s;
  }
  print ""
}
