#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

# Add sources to /etc/apt/sources.list (for kodi)
sudo sh -c "echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/main/binary /' >> /etc/apt/sources.list
sudo sh -c "echo 'deb http://pipplware.pplware.pt/pipplware/dists/jessie/armv7/binary /' >> /etc/apt/sources.list

# Get the key for the sources (for kodi)
wget -O - http://pipplware.pplware.pt/pipplware/key.asc | sudo apt-key add -

# Get the key for tvheadend
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 
sudo apt-get -y install apt-transport-https
echo "deb https://dl.bintray.com/tvheadend/deb jessie release" | sudo tee -a /etc/apt/sources.list

# Update raspberry firmware and software libraries
sudo rpi-update
sudo apt-get -y update 
sudo apt-get -y dist-upgrade


# Get script to init the apps for STB
log_daemon_msg "STBDEV: Get script for initializing STB apps"
cd /home/pi
sudo wget --no-check-certificate https://github.com/cstinv/stbdev/raw/master/init_apps/init_apps.sh
sudo chmod 774 init_apps.sh
sudo chown pi:pi init_apps.sh
echo 'Reboot the raspberry and run init_apps.sh!!!'


