#!/bin/bash
#
# Desing for Ubuntu 14.04 Unity Desktop
# Laravel bootstrap - A simple script to have all stuffs ready for dev in PHP and Laravel.
#
# Only run in the console:
# wget https://raw.githubusercontent.com/eduardogch/laravel-bootstrap/master/Laravel_bootstrap.sh -O - | sh

# *|*|*|*|*|*|*|*|*|*| PHP, vagrant, composer y Laravel *|*|*|*|*|*|*|*|*|*|* #

sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install php5-cli nfs-common nfs-kernel-server

#Install Vagrant
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb
sudo chmod +x vagrant_1.6.5_x86_64.deb
sudo dpkg -i vagrant_1.6.5_x86_64.deb

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

gedit ~/.bashrc

#Change User's Ubuntu Path
#######################################
export PATH=/opt/lampp/bin:~/.composer/vendor/bin:$PATH
alias pozole='ssh pozole@pozole.noip.me'
alias vm='ssh vagrant@127.0.0.1 -p 2222'
#######################################

composer global require "laravel/installer=~1.1"

#Create a Laravel starter site and Vagrant VM
cd ~/git
git clone git://github.com/andrewelkins/Laravel-4-Bootstrap-Starter-Site.git laravelstarter

#Change in VagrantFile
#######################################
#Change this value to admin MySQL with HeidiSQL *Only for dev
mysql_enable_remote   = "true" 

laravel_root_folder   = "/vagrant"
#######################################

# Run the Virtual Machine to start the web app
vagrant up

# Update and Install the VM
vagrant provision

# Alias to have a SSH conection with the VM
vm

# Run commands in Vagrant machine
php artisan migrate
php artisan db:seed
php artisan key:generate

chmod -R 775 /vagrant/app/storage

# Reinstall VM Vagrant
vagrant destroy -f && vagrant up

# Reinstall SSH keys
rm -R ~/.ssh && ssh-keygen -t rsa -C $USER"@localhost"

#Change Nginx  config
sudo nano /etc/nginx/sites-available/vagrant

# Reload config after any change:
sudo service nginx reload


# *|*|*|*|*|*|*|*|*|*| Manual Configurations *|*|*|*|*|*|*|*|*|*|* #

#Laravel Template
https://github.com/andrewelkins/Laravel-4-Bootstrap-Starter-Site

#How to modify the Vagrant File
http://fideloper.github.io/Vaprobash/index.html

#Config xdebug with PHPStorm and Vagrant
http://www.sitepoint.com/install-xdebug-phpstorm-vagrant/

#Install plugins in PHPStorm
Live edit, Angular, Color IDE
