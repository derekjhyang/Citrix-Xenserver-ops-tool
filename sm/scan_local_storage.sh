#!/usr/bin/env bash

sr=$(xe sr-list host=${HOSTNAME} type=lvm --minimal)
xe vdi-list sr-uuid=${sr}

echo "Start to scan the SR: ${sr} ..."
xe sr-scan uuid=${sr}
