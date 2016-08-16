#! /bin/sh
# Install kodi player and default addons

. /lib/lsb/init-functions

set -x

# Add sources to /etc/apt/sources.list
sudo sh -c "echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/main/binary /' >> /etc/apt/sources.list
sudo sh -c "echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/armv7/binary /' >> /etc/apt/sources.list

# Get the key for the sources
wget -O - http://pipplware.pplware.pt/pipplware/key.asc | sudo apt-key add -


sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install kodi

# Create /etc/udev/rules.d/99-input.rules file
sudo sh -c "echo 'SUBSYSTEM==input, GROUP=input, MODE=0660' > /etc/udev/rules.d/99-input.rules"
sudo sh -c "echo 'KERNEL==tty[0-9]*, GROUP=tty, MODE=0660' >> /etc/udev/rules.d/99-input.rules"

# Create /etc/udev/rules.d/10-permissions.rules

sudo sh -c "echo '# input' > /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo 'KERNEL==\"mouse*|mice|event*\",   MODE=\"0660\", GROUP=\"input\"' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo 'KERNEL==\"ts[0-9]*|uinput\",     MODE=\"0660\", GROUP=\"input\"' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo 'KERNEL==js[0-9]*,             MODE=0660, GROUP=input' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo '# tty' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo 'KERNEL==tty[0-9]*,            MODE=0666' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo '# vchiq' >> /etc/udev/rules.d/10-permissions.rules"
sudo sh -c "echo 'SUBSYSTEM==vchiq,  GROUP=video, MODE=0660' >> /etc/udev/rules.d/10-permissions.rules"

# Additional settings for user pi
Run the following commands for user pi:
sudo usermod -a -G audio pi
sudo usermod -a -G video pi
sudo usermod -a -G input pi
sudo usermod -a -G dialout pi
sudo usermod -a -G plugdev pi
sudo usermod -a -G tty pi

#Edit /boot/config.txt for Full HD support
sudo sh -c "echo '  ' >> /boot/config.txt"
sudo sh -c "echo '# Full HD support' >> /boot/config.txt"
sudo sh -c "echo 'gpu_mem=256' >> /boot/config.txt"
sudo sh -c "echo '  ' >> /boot/config.txt"
sudo sh -c "echo '# MPG2 sw decoding' >> /boot/config.txt"
sudo sh -c "echo 'start_x=1' >> /boot/config.txt"

