#!/bin/sh

## Allspaw 5/30/12
##
## Script to pull individual TCP streams out of a pcap file and spit out individual pcap files for them, via tshark.

max_procs=$( grep -c ^processor /proc/cpuinfo )

case "$1" in
    -p) max_procs=$2
        shift 2
esac

if [ "X$1" == "X" ]; then
    echo "Usage: $0 [-p <max procs>] <cap filename>"
    echo "       max procs defaults to the number of CPU cores"
    exit 1
else
    CAPFILE="$1"
fi

echo "** Extracting streams from ${CAPFILE}"

for STREAM_ID in $(tshark -T fields -e tcp.stream -r $CAPFILE | sort -n | uniq)
do 
    running_procs=$( jobs | wc -l )
    while [ ${running_procs} -ge ${max_procs} ]; do
        sleep 0.5
        running_procs=$( jobs | wc -l )
    done

    FLOWCAP_FILE="${CAPFILE}-flow-${STREAM_ID}.pcap"
    echo "** Extracting flow ${STREAM_ID} into ${FLOWCAP_FILE}"
    tshark -r ${CAPFILE} -w ${FLOWCAP_FILE} -R "tcp.stream eq ${STREAM_ID}" &
done

echo "Waiting for child processes to end"
wait
