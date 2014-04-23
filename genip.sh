#!/bin/sh
#
# script to generate ip for given number
# roberto 2007

CNT="$1"

if [ $# -ne 1 ]
then
    echo "genip.sh <num>"
    exit 299
fi

for i in `seq 1 $CNT`
do
    ips="$ips $((RANDOM%=255)).$((RANDOM%=255)).$((RANDOM%=255)).$((RANDOM%=255))"
done

echo "IP LIST:"
echo $ips | tr -s ' ' '\n' | sort -u
