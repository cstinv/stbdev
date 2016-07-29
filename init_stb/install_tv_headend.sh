#! /bin/sh
# Install tv headend 

. /lib/lsb/init-functions

set -x

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 
sudo apt-get -y install apt-transport-https
echo "deb https://dl.bintray.com/tvheadend/deb jessie release" | sudo tee -a /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y install tvheadend
cd /lib/firmware
sudo wget https://github.com/cstinv/stbdev/raw/master/firmware/dvb-demod-si2168-a20-01.fw
sudo wget https://github.com/cstinv/stbdev/raw/master/firmware/dvb-demod-si2168-b40-01.fw
sudo wget https://github.com/cstinv/stbdev/raw/master/firmware/dvb-tuner-si2158-a20-01.fw

#Edit TV Headend parameters
sudo cp -rp /home/hts/.hts /home/pi/
sudo chown pi:pi /home/pi/.hts/tvheadend/superuser
sudo sed -i "s|TVH_USER=.*|TVH_USER=\"pi\"|" /etc/default/tvheadend

