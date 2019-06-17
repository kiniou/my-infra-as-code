#!/bin/sh
set -e
if [ $# -lt 1 ]; then echo "ERROR: Missing device path argument!"; exit 1; fi
device_name=$1

virsh vol-delete \
      --pool default \
      --vol sandbox-data-crypted.img

virsh vol-create-as \
      --pool default \
      --format qcow2 \
      --name sandbox-data-crypted.img \
      --prealloc-metadata \
      --capacity 5G

volume_path=$(virsh vol-path --pool default sandbox-data-crypted.img)

error () {
    echo "$1 is already taken"
    virsh domblklist etc_sandbox | tail -n+3 | cut -d' ' -f2
}

virsh attach-disk --domain etc_sandbox \
      --source ${volume_path} \
      --target ${1} \
      --driver qemu \
      --subdriver qcow2 \
      --targetbus virtio \
      --cache none --live --persistent || error ${1}
