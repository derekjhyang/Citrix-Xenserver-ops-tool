#!/bin/sh

#set -x
QUERY_LIST=vm_list
exec < ${QUERY_LIST}
while read vm
do
    powerstate=$(xe vm-list --minimal uuid=${vm} params=power-state)
    echo "vm: ${vm}, powerstate: ${powerstate}"
done
