#!/bin/sh
kill $(cat $1/pid)
#python $1/mqtt_run.py 2> $2 > $3 & echo $! > $1/pid
/bin/sh $1/run.sh
