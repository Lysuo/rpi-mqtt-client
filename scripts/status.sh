#! /bin/sh

UPTIME=$(uptime | cut -d "," -f1)
echo 'Time: '${UPTIME}
echo wlan0

MAC=$(ifconfig wlan0 | grep -oP 'HWaddr \K\S+')
IP=$(ifconfig wlan0 | grep -oP 'inet addr:\K\S+')
BROAD=$(ifconfig wlan0 | grep -oP 'Bcast:\K\S+')
MASK=$(ifconfig wlan0 | grep -oP 'Mask:\K\S+')
LKQUA=$(iwconfig wlan0 | grep -oP 'Link Quality=\K\S+')
SIGLVL=$(iwconfig wlan0 | grep -oP 'Signal level=\K\S+')
SSID=$(iwconfig wlan0 | grep -oP 'ESSID:\K\S+')
RXB=$(ifconfig wlan0 | grep bytes | cut -d: -f2 | awk '{print $2 $3}')
TXB=$(ifconfig wlan0 | grep bytes | cut -d: -f3 | awk '{print $2 $3}')

echo '\tESSID: '${SSID}
#echo '\tMAC: '${MAC}
echo '\tIP: '${IP}'   Mask: '${MASK}
echo '\tLink Quality: '${LKQUA}
echo '\tSignal Level: '${SIGLVL}' dBm'
echo '\tRX: '${RXB}'   TX: '${TXB}

#################

echo '\nwlan1'

MAC=$(ifconfig wlan1 | grep -oP 'HWaddr \K\S+')
#IP=$(ifconfig wlan1 | grep -oP 'inet addr:\K\S+')
#BROAD=$(ifconfig wlan1 | grep -oP 'Bcast:\K\S+')
#MASK=$(ifconfig wlan1 | grep -oP 'Mask:\K\S+')
SSID=$(iwconfig wlan1 | grep -oP 'ESSID:\K\S+')
RXB=$(ifconfig wlan1 | grep bytes | cut -d: -f2 | awk '{print $2 $3}')
TXB=$(ifconfig wlan1 | grep bytes | cut -d: -f3 | awk '{print $2 $3}')

echo '\tESSID: '${SSID}
#echo '\tMAC: '${MAC}
#echo '\tIP: '${IP}'   Mask: '${MASK}
echo '\tRX: '${RXB}'   TX: '${TXB}
