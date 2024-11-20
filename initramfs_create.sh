#!/bin/bash

#set -o errexit          # Exit on most errors (see the manual)
#set -o errtrace         # Make sure any error trap is inherited
#set -o nounset          # Disallow expansion of unset variables
#set -o pipefail         # Use last non-zero exit code in a pipeline

#if [ $# -eq 0 ]
#then
#    echo "Usage: $0 <target_dir>"
#    exit 1
#fi

set -x

ROOTFS_DIR=/tmp/cpiotest

rm -f /tmp/initramfs.cpio
rm -rf $ROOTFS_DIR
mkdir -p $ROOTFS_DIR
cd $ROOTFS_DIR
mkdir -p {bin,dev,etc,lib,mnt,proc,root,sbin,sys,tmp}

cp -r /tmp/wz_initramfs/* $ROOTFS_DIR/

mknod $ROOTFS_DIR/dev/console c 5 1
mknod $ROOTFS_DIR/dev/null c 1 3
mknod $ROOTFS_DIR/dev/tty0 c 4 0
mknod $ROOTFS_DIR/dev/tty1 c 4 1
mknod $ROOTFS_DIR/dev/tty2 c 4 2
mknod $ROOTFS_DIR/dev/tty3 c 4 3
mknod $ROOTFS_DIR/dev/tty4 c 4 4


find . | cpio -H newc -o > /tmp/initramfs.cpio

rm -rf $ROOTFS_DIR
