#!/usr/bin/env bash

set -Eeuo pipefail

MOUNT_POINT="/mnt/nas"
NAS_IP="192.168.12.178"
NFS_SHARE="/nfs/austin"

if mount | grep -c "$MOUNT_POINT"; then
    echo "Mount already exists at $MOUNT_POINT; exiting"
    exit 0
fi

echo "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

if [[ ! -d "$MOUNT_POINT" ]]; then
    echo "Creating mount point dir=$MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
else
    echo "Mount point dir=$MOUNT_POINT already exists"
fi

echo "Installing nfs-common..."
sudo apt install nfs-common -y

echo "Mounting nas as nfs volume"
sudo mount -t nfs "$NAS_IP:$NFS_SHARE" "$MOUNT_POINT"

echo "Verifying mount"
mount | grep "$MOUNT_POINT"

echo "Adding mount to /etc/fstab"
echo "$NAS_IP:$NFS_SHARE  $MOUNT_POINT  nfs  defaults  0  0" >> sudo tee -a /etc/fstab

