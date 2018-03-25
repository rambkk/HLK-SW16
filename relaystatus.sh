#!/bin/bash
#
# HLK-SW16 scripts
# Copyright (C) 2018 Ram Narula ram@pluslab.com
# Licensed under the GPL-3.0 license.
#

PREFIX="\xaa"
PREFIX2="\x1e"
SWITCHID="\x01"
SWITCHTO="\x01"
SUFFIX="\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\xbb"

SYNTAX="Usage: $0 HOST PORT\n\
where\tHOST := hostname/IP address of the HLK-SW16\
\n\tPORT := port number of the HLK-SW16 (generally: 8080)\
\n\n
\texample#1: $0 10.10.10.199 8080\n\
\t(Get each relay status of HLK-SW16 located at 10.10.10.199 port 8080)\n\
\t\n[script by ram@pluslab.com, if you like this script please drop a note]\n\
"

if [ -z $2 ]
  then
    echo -e "Error: Incomplete command"
    echo -e $SYNTAX
    exit
fi




OUTPUT=`(echo -e "$PREFIX$PREFIX2$SWITCHID$SWITCHTO$SUFFIX";sleep 1)| ncat $1 $2` 
#OUTPUT=`ncat 10.10.97.199 8080 -c "bash -c \"echo -e '$PREFIX$PREFIX2$SWITCHID$SWITCHTO$SUFFIX';sleep 1\""`
#another try ncat 10.10.97.199 8080 -c "bash -c '(echo hello;sleep 3;read -n100 -d\"\\0x00\" abc;echo $abc)'"
USABLE=`echo $OUTPUT | od -A n -v -t x1 | tr -d '\n'|sed 's/.*cc 0c/cc 0c/'|sed 's/ dd .*/ dd/'`
counter=0
for byte in $USABLE; do
	if [ "$counter" -eq "0" ]; then
		counter=$((counter+1))
		continue
	fi
	if [ "$counter" -eq "1" ]; then
		counter=$((counter+1))
		continue
	fi
	if [ "$counter" -eq "18" ]; then
		counter=$((counter+1))
		break
	fi
	

	case "$byte"  in
	01)	STATUS="on" ;;
	02)	STATUS="off" ;;
	*)	STATUS="ERROR" ;;
	esac
	echo Relay \#$((counter-2)): $STATUS 
	counter=$((counter+1))
done
