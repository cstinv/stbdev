#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

cd /home/pi

# Install tvheadend
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_tv_headend.sh
sudo chmod 774 install_tv_headend.sh
sudo . /home/pi/install_tv_headend.sh

# Install kodi
log_daemon_msg "STBDEV: Installing KODI on the STB"
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_kodi.sh
sudo chmod 774 install_kodi.sh
sudo . /home/pi/install_kodi.sh



