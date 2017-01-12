#!/bin/bash

ssh -f -N -R 0:localhost:22 $4 > $1/ssh_data & echo $! > $1/ssh_pid
TEXT="SSH Tunnel ready"
echo $TEXT >> $2
sleep 1

CAT_SSH=$(awk 'NF{p=$0}END{print p}' $2)
COUNTER=0
while [ "$CAT_SSH" == "$TEXT" -a $COUNTER -lt 10 ] ; do   sleep 1;  CAT_SSH=$(awk 'NF{p=$0}END{print p}' $2);  COUNTER=$[COUNTER + 1]; echo $COUNTER >> $3; done

echo $TEXT 
echo $CAT_SSH
rm $1/ssh_data
#ps aux | grep "ssh -f -N -R 0:localhost:22 $4" | grep -v grep | awk '{print $2}'
PID=$(pgrep -f "ssh -f -N -R 0:localhost:22 $4")
echo "PID:" $PID
#rm $1/ssh_pid
