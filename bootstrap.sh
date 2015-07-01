#!/usr/bin/env bash

function install {
  echo installing $1
  shift
  sudo apt-get -y install "$@" >/dev/null 2>&1
}

echo Bootstrap.sh as: `whoami`
echo updating package information ...
sudo apt-get -y update > /dev/null 2>&1

install 'Development Tools' build-essential 

install Git git

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant
sudo -u postgres createdb -O vagrant development
sudo -u postgres createdb -O vagrant test

sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8


echo installing rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

echo installing ruby-build
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

~/.rbenv/bin/rbenv install 2.2.2
~/.rbenv/bin/rbenv global 2.2.2

echo "That's all folks!"


