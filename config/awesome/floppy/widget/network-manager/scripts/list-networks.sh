nmcli device wifi list | awk -F' {2,}' '{ if (NR != 1) {print($3 "," $7)}}'
