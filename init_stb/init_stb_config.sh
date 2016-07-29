#! /bin/sh
# Init stb config

cd /etc/init.d

# Init OS settings
log_daemon_msg "STBDEV: Initializing OS settings for IOT STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/init_os_settings.sh
chmod 774 init_os_settings.sh
. /etc/init.d/init_os_settings.sh

# Init home directory on separate partition
log_daemon_msg "STBDEV: Initializing home directory on separate partition"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/init_home_directory.sh
chmod 774 init_home_directory.sh
. /etc/init.d/init_home_directory.sh

# Install tvheadned
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
sudo wget https://github.com/cstinv/stbdev/raw/master/init_stb/install_tv_headend.sh
chmod 774 install_tv_headend.sh
. /etc/init.d/install_tv_headend.sh



