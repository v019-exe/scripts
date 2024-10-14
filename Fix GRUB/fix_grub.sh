#!/bin/bash
mount /dev/sdXn /mnt  # Cambia sdXn por tu partición raíz
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
chroot /mnt
grub-install /dev/sdX  # Cambia sdX por tu disco
update-grub
exit
reboot