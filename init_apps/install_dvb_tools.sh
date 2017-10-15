#! /bin/sh
# Install DVB tools

. /lib/lsb/init-functions

set -x

# Install DVB tools package
sudo wget sudo wget "https://drive.google.com/uc?export=download&id=0B0-DhBnH4CTKR3RlMVFtTFdOZTA" -O v4l-utils_20171015122900-1_armhf.deb
sudo dpkg -i v4l-utils_20171015122900-1_armhf.deb
sudo apt-get -y install -f

