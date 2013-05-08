#!/usr/bin/env bash
#    display all vm-disk information in the specified Xenserver Resource Pool  
#  

IFS=,
for vm in $(xe vm-list --minimal)
do
   disk_list=$(xe vm-disk-list uuid=${vm})
   echo "vm=${vm}"
   echo "${disk_list}"
done
IFS=
