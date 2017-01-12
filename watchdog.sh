#!/bin/sh

ROOT_DIR=/root/rpi-mqtt-client
NUMBER=$(ps aux | grep "mqtt_run.py" | grep python | grep -v grep | wc -l)

if [ $(ps aux | grep "mqtt_run.py" | grep python | grep -v grep | wc -l) -ne 1 ]
then
  for i in $(ps aux | grep "mqtt_run.py" | grep python | grep -v grep | awk '{print $2}'); do kill ${i}; done 
  echo $NUMBER "process(es) killed"
  /bin/sh $ROOT_DIR/run.sh
  echo "MQTT script relaunched"
  cat $ROOT_DIR/pid
else 
  PID=$(cat $ROOT_DIR/pid)
  date >> $ROOT_DIR/stdout_logs
  echo "1 MQTT script running, PID:"$PID >> $ROOT_DIR/stdout_logs
fi

