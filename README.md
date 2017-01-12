# RPI MQTT client
MQTT client on RPI side, and scripts supported

## Purpose

This mqtt client on RPI side is aimed at controlling my RPI, via an iOS app, which serves as a wifi extender.

List of possibilities given with this setup (actions that can be run from iOS app):
* obtaining a status for both network interfaces involved in the extender (wlan0 and wlan1): ip, ssid, signal level ...
* retrieving the public IP of the home gateway
* obtaining the list of dhcp active leases 
* setting up a reverse ssh tunnel from the RPI to a public server of your choice so that you can ssh into your RPI via a computer with an access to the same public server
* running a socks tunnel from the RPI to a public server, so that all devices connected to the RPI can be redirected to this tunnel
* debug and reboot wlan interface
* restart MQTT client on RPI side
* reboot RI 

To fully work in that way, you also need to setup a MQTT server (or use a public one) and the iOS app I also developped.
iOS app : [iOS rpi client mqtt](https://github.com/Lysuo/mqtt-client-rpi) 

## Prerequisites 

For ssh and socks tunnels, you will need to have an ssh access to a public server and be able to connect from the RPI to the server using a RSA key.

## Installing

Download the source files
Extract into the directory of your choice, ex. /root/rpi-mqtt-client  this directory is named "root directory"

Create the file auth.py into the submentioned root directory, with content: 

```
user="user"  # user used to connect to MQTT server
mdp="password"  # password used to connect to MQTT server
host="my-server.com"  # MQTT server
host_ssh="my-server-ssh.com"  # server to be used  for setting up ssh and socks tunnels
port=1883  # port used by MQTT server
port_socks=8080  # port used for the socks tunnel
```

Update the value of ROOT_DIR into the files run.sh, watchdog.sh and config_mqtt.py
ex. /root/rpi-mqtt-client

Add the below line into the file /etc/rc.local so that the mqtt client be runned at boot time 
```
/bin/sh /root/rpi-mqtt-client/run.sh
```

Configure the cron task to make the watchdog script monitor that the mqtt client is always running.
The watchdog will relaunch the client in the case it has been killed for whatever reason.
```
*/2 * * * * sudo /bin/bash /root/rpi-mqtt-client/watchdog.sh
```


Any questions ? Don't hesitate to contact me
