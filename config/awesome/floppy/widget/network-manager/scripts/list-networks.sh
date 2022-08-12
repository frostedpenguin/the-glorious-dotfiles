nmcli device wifi list | awk '{ if (NR != 1) {print($2)","}}'
