#!/bin/sh
#
# generate random password for given length
# roberto 2007

if [ $# -ne 1 ]
then
    echo "genpass.sh <len>"
    exit 299
fi

len=$1
chars="!\"$%^,-.=@)(_*;\'}{[]&<>|# "
chars="${chars}?0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

while [ "${n:=1}" -le "$len" ]
do
   pass="${pass}${chars:$(($RANDOM%${#chars})):1}"
   let n+=1
done

echo "your pass ---> $pass"
