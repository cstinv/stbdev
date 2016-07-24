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

sed /tmp/1/cmdline.txt -i -e "s|root=/dev/[^ ]*|root=${part2}|"
sed /tmp/2/etc/fstab -i -e "s|^.* / |${part2}  / |"
sed /tmp/2/etc/fstab -i -e "s|^.* /boot |${part1}  /boot |"

if ! grep -q resize /proc/cmdline; then
  sed -i 's/ quiet init=.*$//' /tmp/1/cmdline.txt
fi

rm /tmp/2/etc/init.d/apply_noobs_os_config
cp /tmp/3/init_stb/* /tmp/2/etc/init.d

rm -r /settings/cache/*
umount /tmp/1
umount /tmp/2
umount /tmp/3


