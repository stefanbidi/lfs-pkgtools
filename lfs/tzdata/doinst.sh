#!/bin/sh

if [ ! -f /etc/localtime ]; then
	TZ=`tzselect`
	cp -v /usr/share/zoneinfo/$TZ /etc/localtime
fi
