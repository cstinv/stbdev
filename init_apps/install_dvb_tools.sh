#! /bin/sh
# Install DVB tools

. /lib/lsb/init-functions

set -x

# Install DVB tools package
sudo wget https://github.com/cstinv/stb_pkg/raw/master/v4l-utils_201709280020-1_armhf.deb
sudo dpkg -i v4l-utils_201709280020-1_armhf.deb
sudo apt-get -y install -f


