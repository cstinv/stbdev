#!/bin/sh

set -ex

if [ -z "$part1" ] || [ -z "$part2" ] || [ -z "$part3" ]; then
  printf "Error: missing environment variable part1 or part2 or part3\n" 1>&2
  exit 1
fi

mkdir -p /tmp/1 /tmp/2 /tmp/3

mount "$part1" /tmp/1
mount "$part2" /tmp/2
mount "$part3" /tmp/3

sed /tmp/1/cmdline.txt -i -e "s|root=[^ ]*|root=${part2}|"

sed /tmp/2/etc/fstab -i -e "s|^.* / |${part2}  / |"

sed /tmp/2/etc/fstab -i -e "s|^.* /boot |${part1}  /boot |"

if [ -f /mnt/ssh ]; then
  cp /mnt/ssh /tmp/1/
fi

if [ -f /mnt/ssh.txt ]; then
  cp /mnt/ssh.txt /tmp/1/
fi

if [ -f /settings/wpa_supplicant.conf ]; then
  cp /settings/wpa_supplicant.conf /tmp/1/
  cp /settings/wpa_supplicant.conf /tmp/2/etc/wpa_supplicant
fi

if ! grep -q resize /proc/cmdline; then
  sed -i 's| quiet init=/usr/lib/raspi-config/init_resize.sh||' /tmp/1/cmdline.txt
fi

#cp /tmp/3/apply_noobs_os_config /tmp/2/etc/init.d
cp /tmp/3/get_init_stb_config.sh /tmp/2/etc/init.d
cp /tmp/3/apply_stb_config.service /tmp/2/lib/systemd/system

rm -r /settings/cache/*
umount /tmp/1
umount /tmp/2
umount /tmp/3


