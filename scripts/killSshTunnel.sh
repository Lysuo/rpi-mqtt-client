#!/bin/bash

PATTERN="ssh -f -N -R 0:localhost:22 $1"
#NB_PROCESS=$(ps aux | grep "$PATTERN" | grep -v grep | wc -l)
NB_PROCESS=$(pgrep -f "$PATTERN" | wc -l)
#for i in $(ps aux | grep "$PATTERN" | grep -v grep | awk '{print $2}'); do kill ${i}; done
for i in $(pgrep -f "$PATTERN"); do kill ${i}; done
echo ${NB_PROCESS}' ssh tunnels killed'
