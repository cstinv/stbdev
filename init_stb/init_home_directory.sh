#! /bin/sh
# Move home directory to separate data partition

cd /home
sudo cp -rp ./ /media/pi/home
sudo umount /media/pi/home
sudo rm -rf /media/pi/home
sudo mv /home /old_home
sudo mkdir home
sudo chmod 666 /etc/fstab
sudo echo "/dev/mmcblk0p8 /home ext4 defaults,noatime,nodiratime 0 0" >> /etc/fstab
sudo chmod 444 /etc/fstab
sudo mount /home
#sudo rm -fr /old_home

