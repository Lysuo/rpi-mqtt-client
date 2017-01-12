#! /bin/sh

ifdown wlan0
sleep 5s
wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf &
sleep 2s
ifup wlan0
sleep 15s
