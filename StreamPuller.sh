#!/bin/sh

## Allspaw 5/30/12
##
## Script to pull individual TCP streams out of a pcap file and spit out individual pcap files for them, via tshark.

for stream_id in `/usr/local/bin/tshark -T fields -e tcp.stream -r ./conn1.cap `
 do 
	tshark -r conn1.cap -w server"$stream_id".pcap -R "tcp.stream eq $stream_id"
 done
