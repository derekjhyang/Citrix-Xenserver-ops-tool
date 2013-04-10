#!/usr/bin/env bash
# [author] 
#     winnie yang
# [description]
#     get a available vlan tag in Citrix Xenserver
#     it will return a vlan tag in ascending order
#


function get_available_vlan_tag() {
    local i=0
    VLAN_TAG_LIST=$(xe vlan-list params=tag --minimal | awk 'BEGIN{FS=","} {for(i=1;i<NF;i++) print $i}' | sort -n | uniq)
    for tag in ${VLAN_TAG_LIST}
    do
        tagArr[$i]=${tag}
        let i++
    done
    local numTag=${#tagArr[@]}
    if [ "${numTag}" == "0" ];then
        echo 1
    else
        index=$(expr ${#tagArr[@]} - 1)
        echo $(expr ${tagArr[$index]} + 1)
    fi
}


TAG=$(get_available_vlan_tag)
echo $TAG
