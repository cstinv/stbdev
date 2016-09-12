#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

# Install tvheadend
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_tvheadend.sh
sudo chmod 774 install_tvheadend.sh
. /home/pi/install_tvheadend.sh

# Install kodi
log_daemon_msg "STBDEV: Installing KODI on the STB"
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_kodi.sh
sudo chmod 774 install_kodi.sh
. /home/pi/install_kodi.sh



