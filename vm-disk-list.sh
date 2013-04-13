#!/usr/bin/env bash

IFS=,
for vm in $(xe vm-list --minimal)
do
   disk_list=$(xe vm-disk-list uuid=${vm})
   echo "vm=${vm}"
   echo "${disk_list}"
done
IFS=
