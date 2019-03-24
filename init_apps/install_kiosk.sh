#! /bin/sh
# Install kiosk mode

. /lib/lsb/init-functions

set -x

# Install required packages
sudo apt-get -y install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox chromium-browser

# Configure openbox
cd /home/pi/initstb
cat > autostart << EOF
# Disable any form of screen saver / screen blanking / power management
xset s off
xset s noblank
xset -dpms

# Allow quitting the X server with CTRL-ATL-Backspace
setxkbmap -option terminate:ctrl_alt_bksp

# Start Chromium in kiosk mode
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/'Local State'
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/; s/"exit_type":"[^"]\+"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences
#chromium-browser --disable-infobars --kiosk 'http://your-url-here'in/agetty --autologin $SUDO_USER --noclear %I $TERM
chromium-browser 'https://areena.yle.fi/tv'
EOF
sudo chown root:root autostart
sudo chmod 755 autostart 
sudo mv autostart /etc/xdg/openbox/autostart

