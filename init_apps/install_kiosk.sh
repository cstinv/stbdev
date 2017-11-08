#! /bin/sh
# Install kiosk mode

. /lib/lsb/init-functions

set -x

# Create the kiosk-user
sudo useradd -m aionkiosk 

# Install required packages
sudo apt-get -y install sudo xorg chromium-browser openbox lightdm 

# Configure auto-login
sudo sed -i '/# Seat configuration/ r lightdm.insert' /etc/lightdm/lightdm.conf

# Create the openbox config directory for kiosk-user if it does not exist.
mkdir -p /home/aionkiosk/.config/openbox
sudo mv autostart /home/aionkiosk/.config/openbox/autostart

