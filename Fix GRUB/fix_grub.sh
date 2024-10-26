#!/bin/bash
mount /dev/sdXn /mnt
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
chroot /mnt
grub-install /dev/sdX
update-grub
exit
reboot
