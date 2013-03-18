#!/usr/bin/env bash
# [Description]
#    network bulk destroy in Citrix Xenserver
# [Author]
#    Winnie Yang
#
#
network_destroy() {
    set -x
    network_name=$1
    IFS=,
    for network in $(xe network-list name-label=$1 --minimal)
    do
        xe network-destroy uuid=$network
    done
    IFS=
    set +x
}


network_destroy "<network-name>"
