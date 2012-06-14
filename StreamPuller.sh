#!/bin/sh

## Allspaw 5/30/12
##
## Script to pull individual TCP streams out of a pcap file and spit out individual pcap files for them, via tshark.

if [ "X$1" == "X" ]; then
    echo "Usage: $0 <cap filename>"
    exit 1
else
    CAPFILE="$1"
fi

echo "** Extracting streams from $CAPFILE"

for STREAM_ID in $(tshark -T fields -e tcp.stream -r $CAPFILE | sort -n | uniq)
do 
    FLOWCAP_FILE="$CAPFILE-flow-$STREAM_ID.pcap"

    echo "** Extracting flow $STREAM_ID into $FLOWCAP_FILE"
    tshark -r $CAPFILE -w $FLOWCAP_FILE -R "tcp.stream eq $STREAM_ID"
done