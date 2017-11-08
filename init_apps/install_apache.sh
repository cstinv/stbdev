#! /bin/sh
# Install apache

. /lib/lsb/init-functions

set -x

# Install apache web server
sudo apt-get install apache2

# Allow cross-domain access
sudo a2enmod headers
sudo sed -i '/DocumentRoot \/var\/www\/html/ r 000-default.insert' /etc/apache2/sites-available/000-default.conf


