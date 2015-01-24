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

#Install composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


#Change User's Ubuntu Path
gedit ~/.bashrc
#######################################
export PATH=/opt/lampp/bin:~/.composer/vendor/bin:$PATH
alias pozole='ssh pozole@pozole.noip.me'
alias vm='homestead ssh'
#######################################


#Install Vagrant Box for Laravel
vagrant box add laravel/homestead
composer global require "laravel/homestead=~2.0"

#Init homestead
homestead init


#Change for this Values
nano ~/.homestead/Homestead.yaml
#######################################
---
ip: "192.168.10.10"
memory: 2048
cpus: 1

authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/git
      to: /home/vagrant/Code

sites:
    - map: taxicontrol.dev
      to: /home/vagrant/Code/taxi-control/public
    - map: starterlaravel.dev
      to: /home/vagrant/Code/starterlaravel/public

databases:
    - taxicontrol
    - laravel

variables:
    - key: APP_ENV
      value: local
#########################################



#Change for this Values
nano ~/.homestead/after.sh
#########################################
# Taxi Control App
echo "Execute Taxi Control initial commands"
su vagrant -c /home/vagrant/Code/taxi-control/local-script.sh
#########################################


#Refresh settings VM
homestead up --provision

#Reinstall SSH keys
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
