#! /bin/sh
# Init OS settings

sudo sed -i 's/XKBLAYOUT.*/XKBLAYOUT="fi"/' /etc/default/keyboard
sudo sed -i 's/rootwait/rootwait usbhid.mousepoll=0/' /boot/cmdline.txt
