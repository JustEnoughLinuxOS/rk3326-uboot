#!/bin/sh

#
# fusing script for ODROID-GO2 based on Rockchip RK3326
#


IDBLOADER=idbloader.img
UBOOT=uboot.img
TRUST=trust.img


./make.sh odroidgoa && 
sshpass -p "root" scp ./arch/arm/dts/rg351mp-uboot.dtb root@$1:/boot && 
sshpass -p "root" scp ./arch/arm/dts/rg351v-uboot.dtb root@$1:/boot && 
sshpass -p "root" scp ./arch/arm/dts/rg351p-uboot.dtb root@$1:/boot && 
sshpass -p "root" scp ./sd_fuse/$IDBLOADER root@$1:/tmp && 
sshpass -p "root" scp ./sd_fuse/$UBOOT root@$1:/tmp && 
sshpass -p "root" scp ./sd_fuse/$TRUST root@$1:/tmp && 
sshpass -p "root" ssh root@$1 dd if=/tmp/$IDBLOADER of=/dev/mmcblk0 conv=notrunc bs=512 seek=64 &&
sshpass -p "root" ssh root@$1 dd if=/tmp/$UBOOT of=/dev/mmcblk0 conv=notrunc bs=512 seek=16384 &&
sshpass -p "root" ssh root@$1 dd if=/tmp/$TRUST of=/dev/mmcblk0 conv=notrunc bs=512 seek=24576 &&
sshpass -p "root" ssh root@$1 /bin/sh -c "/sbin/reboot"


