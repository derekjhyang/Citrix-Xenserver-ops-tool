#!/usr/bin/env bash
# [description]
#    calulate vm total amnout
# [example]
#    ./vm-amount-query.sh power-state (running|suspended|halted)
#                         all

case $1 in
    power-state)
        shift
        xe vm-list power-state=$1 --minimal | awk 'BEGIN{FS=","} {print NF}'
    ;;
    all)
        xe vm-list --minimal | awk 'BEGIN{FS=","} {print NF}'
    ;;
    *)
        echo "Usage: $0 power-state (running|suspended|halted)"
        echo "       $0 all"
        exit 1
    ;;
esac
exit 0
