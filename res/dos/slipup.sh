#!/bin/sh
# slipup.sh - set up SLIP bridge
# Copyright (C) 2018 David McMackins II
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#

BAUD=115200
MTU=576
IF=sl0
TTY=/dev/ttyS0
IP=192.168.10.6
GATEWAY=192.168.10.5
MAC=00:e0:c5:5a:60:39

fail()
{
	beep -f 131

	for pid in $(pgrep -P $$)
	do
		kill $pid
	done

	exit 1
}

if stty -F "$TTY" -clocal -crtscts "$BAUD"
then
	beep -f 262
else
	fail
fi

nohup /sbin/slattach -d -v -L -m -p slip -s "$BAUD" "$TTY" >"$HOME/slip.log" 2>&1 &

sleep 1
if /sbin/ifconfig "$IF" "$GATEWAY" pointopoint "$IP" mtu "$MTU" up
then
	beep -f 524
else
	fail
fi

if /usr/sbin/arp -s "$IP" "$MAC" pub
then
	beep -f 1048
else
	fail
fi

echo 1 >/proc/sys/net/ipv4/ip_forward

