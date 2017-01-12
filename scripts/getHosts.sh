#! bin/sh
egrep "lease|hostname|hardware|ends|\}" /var/lib/dhcp/dhcpd.leases | grep -v "#"
