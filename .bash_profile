# Various bash profile things that are useful.

##
## Tshark bits
##
# MySQL tshark dissector more: http://www.wireshark.org/docs/dfref/m/mysql.html
function mshark() { /usr/local/bin/tshark -d tcp.port==3306,mysql -T fields -R mysql.query -e frame.time -e ip.src -e ip.dst -e mysql.query -r $1 ;}

# PostgreSQL tshark dissector
function pshark() { /usr/local/bin/tshark -d tcp.port==3306,pgsql -T fields -R pgsql.query -e frame.time -e ip.src -e ip.dst -e pgsql.query -r $1 ;}

# Memcached tshark dissector more: http://www.wireshark.org/docs/dfref/m/memcache.html
function memshark() { /usr/local/bin/tshark -d tcp.port==11211,memcache -T fields -R memcache.command -e frame.time -e ip.src -e ip.dst -e memcache.key -e tcp.analysis.ack_rtt -r $1 ;}

##
## Curl
alias curltime="curl -o /dev/null -s -w 'Return Code = %{http_code}\nBytes recieved = %{size_download}\nDNS = %{time_namelookup}\nConnect = %{time_connect} \nPretransfer = %{time_pretransfer}\nStart transfer = %{time_starttransfer}\nTotal = %{time_total}\n'"
