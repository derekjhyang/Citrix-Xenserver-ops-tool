#!/usr/bin/env bash
#  find all vms in the specified NFS SR
#
# [Examples]
#   Which SR you want to search:csie1
#                 VM-UUID                   VM-NAME         VDI
#d4bbdb79-5547-3a43-32db-a7993066d1a5    test-route-image        20a6c048-1983-4981-aace-2995c196d809
#d5cb66da-875b-f5b6-8d3b-12a6bac2199d    test-vpn-image  3de42924-f5e6-4780-a282-67b825073d31
#5dc3ba78-528a-a9ab-f838-58293fb3cc63    froyo(2)        1f2bbeac-d21f-4fc8-888a-1a1751db7e6c
#
#



# enable debuggin mode
#set -x
IFS=,


sr_list=$(xe sr-list --minimal type=nfs)
i=0
for sr in ${sr_list}
do
    name=$(xe sr-list --minimal uuid=${sr} params=name-label)
    echo "-- $name"
    SRNameArr[$i]=${name}
    SRUUIDArr[$i]=${sr}
    let i++
done
read -p "Which SR you want to search:" SR

for (( i=0; i<${#SRNameArr[@]}; i++ ))
do
    if [[ ${SRNameArr[$i]} == $SR ]];then
        sr_uuid=${SRUUIDArr[$i]}
        vdi_list=$(xe vdi-list sr-uuid=${sr_uuid} --minimal)
        echo "                 VM-UUID                   VM-NAME               VDI-NAME                  VDI-UUID"
        for vdi in ${vdi_list}
        do
            vdi_name=$(xe vdi-list uuid=${vdi} params=name-label --minimal)
            vm_uuid=$(xe vbd-list vdi-uuid=${vdi} params=vm-uuid --minimal)
            vm_name=$(xe vbd-list vdi-uuid=${vdi} params=vm-name-label --minimal)
            if [ -z ${vm_uuid} ];then
                vm_uuid="                  null          "
            fi
            if [ -z ${vm_name} ];then
                vm_name="    null          "
            fi
            echo -e "${vm_uuid}\t${vm_name}\t${vdi_name}\t${vdi}"
        done
        break
    fi
done
IFS=
