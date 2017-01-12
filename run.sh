#!/bin/sh

ROOT_DIR=/root/rpi-mqtt-client
rm $ROOT_DIR/mqtt_logs
python $ROOT_DIR/mqtt_run.py 2> $ROOT_DIR/err_logs > $ROOT_DIR/stdout_logs & echo $! > $ROOT_DIR/pid
