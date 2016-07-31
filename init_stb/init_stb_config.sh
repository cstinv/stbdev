#! /bin/sh
# Init stb config

. /lib/lsb/init-functions

set -x

# Init OS settings
log_daemon_msg "STBDEV: Initializing OS settings for IOT STB"
cd /etc/init.d
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/init_os_settings.sh
chmod 774 init_os_settings.sh
. /etc/init.d/init_os_settings.sh

# Init home directory on separate partition
log_daemon_msg "STBDEV: Initializing home directory on separate partition"
cd /etc/init.d
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/init_home_directory.sh
chmod 774 init_home_directory.sh
. /etc/init.d/init_home_directory.sh

# Get script to init the apps for STB
log_daemon_msg "STBDEV: Get script for initializing STB apps"
cd ~
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/init_apps.sh
chmod 774 init_apps.sh
log_daemon_msg "STBDEV: Finalized scripts"


