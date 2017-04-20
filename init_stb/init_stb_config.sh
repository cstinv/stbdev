#! /bin/sh
# Init stb config

. /lib/lsb/init-functions

set -x

# Init OS settings
log_daemon_msg "STBDEV: Initializing OS settings for IOT STB"
cd /etc/init.d
sudo wget --no-check-certificate https://github.com/cstinv/stbdev/raw/master/init_stb/init_os_settings.sh
chmod 774 init_os_settings.sh
. /etc/init.d/init_os_settings.sh

# Init home directory on separate partition
log_daemon_msg "STBDEV: Initializing home directory on separate partition"
cd /etc/init.d
sudo wget --no-check-certificate https://github.com/cstinv/stbdev/raw/master/init_stb/init_home_directory.sh
chmod 774 init_home_directory.sh
. /etc/init.d/init_home_directory.sh

# Get script to init the apps for STB
log_daemon_msg "STBDEV: Get script for initializing STB apps"
cd /home/pi
sudo wget --no-check-certificate https://github.com/cstinv/stbdev/raw/master/init_apps/init_os.sh
sudo chmod 774 init_os.sh
sudo chown pi:pi init_os.sh
log_daemon_msg "STBDEV: Finalized scripts"

# Enable ssh 
sudo sh -c "echo '1' >> /boot/ssh"


