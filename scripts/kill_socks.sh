#!/bin/bash

kill $(head -n 1 /tmp/subnetproxy/redsocks.log)
iptables-restore /etc/iptables.ipv4.nat

rm -r /tmp/subnetproxy/
PATTERN="ssh -f -N -D $2 $3"
#NB_PROCESS=$(ps aux | grep "$PATTERN" | grep -v grep | wc -l)
#PROCESS=$(ps aux | grep "$PATTERN" | grep -v grep)

NB_PROCESS=$(pgrep -f "$PATTERN" | wc -l)
PROCESS=$(pgrep -f "$PATTERN")

for i in $(pgrep -f "$PATTERN"); do kill ${i}; done
#for i in $(ps aux | grep "$PATTERN" | grep -v grep | awk '{print $2}'); do kill ${i}; done
echo ${NB_PROCESS}' ssh socks tunnels killed'

rm $1/socks_pid
rm $1/socks_ssh_logs
