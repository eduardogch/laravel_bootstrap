#!/bin/bash
#
# Desing for Ubuntu 14.04 Unity Desktop
# Laravel bootstrap - A simple script to have all stuffs ready for dev in PHP and Laravel.
#
# Only run in the console:
# wget https://raw.githubusercontent.com/eduardogch/laravel-bootstrap/master/Laravel_bootstrap.sh -O - | sh

# *|*|*|*|*|*|*|*|*|*| PHP, vagrant, composer y Laravel *|*|*|*|*|*|*|*|*|*|* #

sudo apt-get install php5-cli virtualbox

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

gedit ~/.bashrc
#Agregar en el Path de ubuntu
export PATH=/opt/lampp/bin:~/.composer/vendor/bin:$PATH
alias pozole='ssh pozole@pozole.noip.me'
alias vm-ssh='ssh vagrant@127.0.0.1 -p 2222'

composer global require "laravel/installer=~1.1"

#Crear una VM de vagrant

ssh-keygen -t rsa -C "eduardo@homestead"

vagrant box add laravel/homestead
cd ~/git
git clone https://github.com/laravel/homestead.git Homestead

#Crear un projecto en Laravel
cd ~/git
laravel new blog


# *|*|*|*|*|*|*|*|*|*| Manual Configurations *|*|*|*|*|*|*|*|*|*|* #

#Install 2 or more apps in vagrant
http://www.sitepoint.com/6-reasons-move-laravel-homestead/

#Config xdebug with PHPStorm and Vagrant
http://www.sitepoint.com/install-xdebug-phpstorm-vagrant/

#Install plugins in PHPStorm
Live edit, Angular, Color IDE
