#! /bin/sh
# Move home directory to separate data partition

# Unmount home directory partition just in case
homedir=$(df -h | grep -o "/media/pi/home.*")
log_daemon_msg "STBDEV: home directory = $homedir"
sudo umount $homedir

sudo mkdir /tmp/home
sudo mount /dev/mmcblk0p8 /tmp/home
cd /home
sudo cp -rp ./ /tmp/home
sudo umount /tmp/home
sudo rm -rf /tmp/home
sudo mv /home /old_home
sudo mkdir /home
sudo chmod 666 /etc/fstab
sudo echo "/dev/mmcblk0p8 /home ext4 defaults,noatime,nodiratime 0 0" >> /etc/fstab
sudo chmod 444 /etc/fstab
sudo mount /home
#sudo rm -fr /old_home

