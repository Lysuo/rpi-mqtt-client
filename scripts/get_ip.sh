#! /bin/sh

ROOT_DIR=$1
wget http://ipinfo.io/ip -o $ROOT_DIR/ip.out -O $ROOT_DIR/ip
sleep 1s
cat $ROOT_DIR/ip
rm $ROOT_DIR/ip*
