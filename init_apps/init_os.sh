#! /bin/sh
# Init apps for STB

. /lib/lsb/init-functions

set -x

# Set the correct timezone
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime

# Change repository
#sudo sed -i -- 's/http:\/\/mirrordirector.raspbian.org\/raspbian\//http:\/\/mirrors.ocf.berkeley.edu\/raspbian\/raspbian\//g' /etc/apt/sources.list

# Add sources to /etc/apt/sources.list (for kodi)
#deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi
# Below line dropped 11.11.2017 to test if needed
#sudo sh -c "echo 'deb http://pipplware.pplware.pt/pipplware/dists/stretch/main/binary /' >> /etc/apt/sources.list"

# Get the key for the sources (for kodi)
#wget -O - http://pipplware.pplware.pt/pipplware/key.asc | sudo apt-key add -

# Get the key for tvheadend
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 
#sudo apt-get -y install software-properties-common
#sudo apt-add-repository "https://dl.bintray.com/tvheadend/deb release"

#sudo apt-get -y install apt-transport-https
#echo "deb https://dl.bintray.com/tvheadend/deb jessie release" | sudo tee -a /etc/apt/sources.list

# Update raspberry firmware and software libraries
sudo rpi-update
sudo apt-get -y update 
sudo apt-get -y dist-upgrade

# Add autologin user (to pi)
cd /home/pi
mkdir initstb
cd initstb
sudo systemctl set-default multi-user.target
sudo ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
cat > autologin.conf << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $SUDO_USER --noclear %I $TERM
EOF
sudo chown root:root autologin.conf
sudo chmod 755 autologin.conf
sudo mv autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf

# Get script to init the apps for STB
log_daemon_msg "STBDEV: Get script for initializing STB apps"
cd /home/pi/initstb
sudo wget --no-check-certificate https://github.com/cstinv/stbdev/raw/master/init_apps/init_apps.sh
sudo chmod 774 init_apps.sh
sudo chown pi:pi init_apps.sh
echo 'Reboot the raspberry and run initstb/init_apps.sh!!!'



