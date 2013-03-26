#!/usr/bin/env bash

domid=`xe vm-list uuid=$1 params=dom-id --minimal`
hostuuid=`xe vm-list uuid=$1 params=resident-on --minimal`
hostname=`xe host-list uuid=$hostuuid params=name-label --minimal`
if [ "`hostname`-" == "$hostname-" ]
then
        echo locally resident
        ps aux|grep vnc|grep "/$domid/"|awk '{print $2}'|xargs kill >/dev/null 2>/dev/null
        echo connecting, use ctrl-] to disconnect
        /opt/xensource/bin/xl console $domid
else
        echo resident on $hostname, domid=$domid
fi
