#! /bin/sh
# Install tv headend 

. /lib/lsb/init-functions

set -x

# Install preconfigured options for tvheadend
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/tvheadend.seed
sudo debconf-set-selections ./tvheadend.seed

# Install tvheadend software
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/tvheadend/tvheadend_4.1-2483~gff5dfd4_armhf.deb
sudo dpkg -i tvheadend_4.1-2483~gff5dfd4_armhf.deb
sudo apt-get -y install -f

# Get the needed firmware
cd /lib/firmware
sudo wget https://github.com/cstinv/stbdev/raw/master/firmware/dvb-demod-si2168-b40-01.fw
sudo wget https://github.com/cstinv/stbdev/raw/master/firmware/dvb-tuner-si2158-a20-01.fw

#Edit TV Headend parameters
sudo cp -rp /home/hts/.hts /home/pi/
sudo chown -R pi:pi /home/pi/.hts
sudo sed -i "s|TVH_USER=.*|TVH_USER=\"pi\"|" /etc/default/tvheadend

#Get the tvheadend init script
cd /home/pi
sudo wget https://github.com/cstinv/stbdev/raw/master/init_apps/tvh_createchannels.py
echo "Run python tvh_createchannels.py to install TV channels"
