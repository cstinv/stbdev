#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

cd ~

# Install tvheadend
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_tv_headend.sh
chmod 774 install_tv_headend.sh
. ~/install_tv_headend.sh

# Install kodi
log_daemon_msg "STBDEV: Installing KODI on the STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_kodi.sh
chmod 774 install_kodi.sh
. ~/install_kodi.sh



