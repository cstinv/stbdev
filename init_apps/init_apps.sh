#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

cd ~

# Install tvheadned
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/install_tv_headend.sh
chmod 774 install_tv_headend.sh
. ~/install_tv_headend.sh



