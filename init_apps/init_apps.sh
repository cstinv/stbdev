#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

# Install tvheadend
log_daemon_msg "STBDEV: Installing tvheadend on the STB"
cd /home/pi/initstb
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_tvheadend.sh
sudo chmod 774 install_tvheadend.sh
. /home/pi/initstb/install_tvheadend.sh

# Install DVB tools
log_daemon_msg "STBDEV: Installing DVB tools on the STB"
cd /home/pi/initstb
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_dvb_tools.sh
sudo chmod 774 install_dvb_tools.sh
. /home/pi/initstb/install_dvb_tools.sh

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

# Install apache
log_daemon_msg "STBDEV: Installing apache web server"
cd /home/pi/initstb
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_apache.sh
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/000-default.insert
sudo chmod 774 install_apache.sh
. /home/pi/initstb/install_apache.sh

# Install h264ify extension for chrome 
# Refer to browser_chrome_install_extension.txt
sudo mkdir /usr/share/chromium
sudo mkdir /usr/share/chromium/extensions
cd /home/pi/initstb
sudo wget https://github.com/cstinv/stbdev/raw/master/3rdparty/h264ify_v1.0.9.crx
sudo mv h264ify_v1.0.9.crx /usr/share/chromium/extensions
sudo wget https://github.com/cstinv/stbdev/raw/master/3rdparty/aleakchihdccplidncghkekgioiakgal.json
sudo mv aleakchihdccplidncghkekgioiakgal.json /usr/share/chromium/extensions

# Install kiosk
log_daemon_msg "STBDEV: Installing kiosk mode"
cd /home/pi/initstb
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/install_kiosk.sh
#sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/lightdm.insert
#sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/autostart
#sudo chmod 774 install_kiosk.sh
. /home/pi/initstb/install_kiosk.sh

