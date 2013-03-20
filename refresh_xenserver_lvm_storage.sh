#!/usr/bin/env bash
# date: 2013/03/20
# author: winnie yang
#
#

set -x
vg=$( vgdisplay -s | awk '{print $1}' | sed 's/"//g' )
for lvpath in $(lvdisplay -c | awk 'BEGIN {FS=":"} {print $1}' | sed '1d')
do
    lv_vdi=$( echo ${lvpath##/*/} | sed 's/VHD-//' )
    vdi=$( xe vdi-list uuid=${lv_vdi} --minimal )
    if [ -z $vdi ]; then
        echo "${lv_vdi} is not found in Xenserver database, so we will use 'lvremove' to remove it here..."
        lvremove ${lvpath}
    fi
done

echo "Start to scan local volume in $vg"
lvscan

local_sr=$( xe sr-list host=${HOSTNAME} type=lvm --minimal )
xe sr-scan uuid=${local_sr}
