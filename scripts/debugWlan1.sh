#! /bin/sh

ifdown br0 
sleep 2s
ifup br0 
sleep 2s
ifconfig | cut -d" " -f1 | grep 'wlan\|eth\|br'
service hostapd restart
service isc-dhcp-server force-reload
