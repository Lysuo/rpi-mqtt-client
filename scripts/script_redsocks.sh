#!/bin/bash
########################################################################
# This bash script will create a socksifying router and pass all subnet
# traffic through
# a socks5 proxy. As the script is now written, local traffic is not
# proxied, however, make the change noted below and it will be.
#
#
# Also, the script requires the redsocks, openssh-client, and iptables
# packages be installed as well.

########################################################################

########################################################################
# Define various configuration parameters.
########################################################################

SOCKS_PORT=$2
REDSOCKS_TCP_PORT=$(expr $SOCKS_PORT + 1)
TMP=/tmp/subnetproxy ; mkdir -p $TMP
REDSOCKS_LOG=$TMP/redsocks.log
REDSOCKS_CONF=$TMP/redsocks.conf

cp $1/redsocks.conf.bak $TMP/redsocks.conf

########################################################################
#redsocks configuration
########################################################################

# To use tor just change the redsocks output port from 1080 to 9050 and
# replace the ssh tunnel with a tor instance.

########################################################################
# start redsocks
########################################################################

sudo redsocks -c $REDSOCKS_CONF -p $TMP/redsocks.log &! > $1/socks_pid

########################################################################
# proxy iptables setup
########################################################################

# create the REDSOCKS target
sudo iptables -t nat -N REDSOCKS

# don't route unroutable addresses
sudo iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
#sudo iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
sudo iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

# redirect statement sends everything else to the redsocks
# proxy input port
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports $REDSOCKS_TCP_PORT

# if it came in on eth0, and it is tcp, send it to REDSOCKS
sudo iptables -t nat -A PREROUTING -i br0 -p tcp -j REDSOCKS

# Use this one instead of the above if you want to proxy the local
# networking in addition to the subnet stuff. Redsocks listens on
# all interfaces with local_ip = 0.0.0.0 so no other changes are
# necessary.
#sudo iptables -t nat -A PREROUTING -p tcp -j REDSOCKS

# don't forget to accept the tcp packets from eth0
sudo iptables -A INPUT -i wlan0 -p tcp --dport $REDSOCKS_TCP_PORT -j ACCEPT
#sudo iptables -A INPUT -i wlan1 -p tcp --dport $REDSOCKS_TCP_PORT -j ACCEPT

#cat /tmp/subnetproxy/redsocks.log
ssh -f -N -D $SOCKS_PORT $3 > $1/socks_ssh_logs &

echo 'Tunnel socks running'
