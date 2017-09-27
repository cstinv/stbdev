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

# Install DVB tools
log_daemon_msg "STBDEV: Installing DVB tools on the STB"
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_dvb_tools.sh
sudo chmod 774 install_dvb_tools.sh
. /home/pi/install_dvb_tools.sh

# Install setup bash commands
log_daemon_msg "STBDEV: Installing bash setup commands"
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/.bash_stb_defs
sudo chmod 774 .bash_stb_defs
# Add execution of script to .bashrc
echo "" >> .bashrc
echo "" >> .bashrc
echo "# Execute STB specific definitions if file present" >> .bashrc
echo "if [ -f ~/.bash_stb_defs ]; then" >> .bashrc
echo "    . ~/.bash_stb_defs" >> .bashrc
echo "fi" >> .bashrc
echo "" >> .bashrc


