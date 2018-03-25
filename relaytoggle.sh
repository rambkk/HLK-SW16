#!/bin/bash
#
# HLK-SW16 scripts
# Copyright (C) 2018 Ram Narula ram@pluslab.com
# Licensed under the GPL-3.0 license.
#

PREFIX="\xaa"
PREFIX2="\x0f"
SUFFIX="\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\xbb"

SYNTAX="Usage: $0 RelayID MODE HOST PORT\n\
where\tRelayID := {0-F|all}\
\n\tMODE := on|off\
\n\tHOST := hostname/IP address of the HLK-SW16
\n\tPORT := port number of the HLK-SW16 (generally: 8080)
\n\
\n\
\texample#1: $0 15 off 10.10.10.199 8080\n\
\t(Turn RelayID#15 off)\n\
\n\
\texample#2: $0 all on 10.10.10.199 8080\n\
\t(Turn all relays on)\n\
\t\n
\t\n[script by ram@pluslab.com, if you like this script please drop a note]\n\
"

if [ -z $4 ]
  then
    echo -e "Error: Incomplete command"
    echo -e $SYNTAX
    exit
fi

case "$1" in
0) SWITCHID="\x00" ;;
1) SWITCHID="\x01" ;;
2) SWITCHID="\x02" ;;
3) SWITCHID="\x03" ;;
4) SWITCHID="\x04" ;;
5) SWITCHID="\x05" ;;
6) SWITCHID="\x06" ;;
7) SWITCHID="\x07" ;;
8) SWITCHID="\x08" ;;
9) SWITCHID="\x09" ;;
10) SWITCHID="\x0a" ;;
11) SWITCHID="\x0b" ;;
12) SWITCHID="\x0c" ;;
13) SWITCHID="\x0d" ;;
14) SWITCHID="\x0e" ;;
15) SWITCHID="\x0f" ;;
all)	if [ "$2" == "on" ]; then 
		SWITCHID="\x01"
		PREFIX2="\x0a" 
	fi
	if [ "$2" == "off" ]; then 
		SWITCHID="\x02"
		PREFIX2="\x0b" 
	fi
	;;


*) echo -e "Error: invalid RelayID, only 0-15 or all"
   ERROR="1"
   ;;
esac

case "$2" in
on)	#echo "On $1" 
	SWITCHTO="\x01" ;;
off)	#echo  "Off $1"
	SWITCHTO="\x02" ;;

*)	echo -e "Error: invalid mode, only on or off"
	ERROR="1"
	;;
esac

if [ ! -z $ERROR ]; then
	echo -e $SYNTAX
fi

ncat $3 $4 -c "bash -c \"echo -e '$PREFIX$PREFIX2$SWITCHID$SWITCHTO$SUFFIX'\""

