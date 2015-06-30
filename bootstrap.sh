#!/usr/bin/env bash

function install {
  echo installing $1
  shift
  apt-get -y install "$@" >/dev/null 2>&1
}

echo Bootstrap.sh
echo updating package information ...
apt-get -y update > /dev/null 2>&1

install 'Development Tools' build-essential 

install Git git

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant
sudo -u postgres createdb -O vagrant development
sudo -u postgres createdb -O vagrant test

update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo installing rbenv
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
exec $SHELL

echo installing ruby-build
git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bashrc
exec $SHELL

rbenv install 2.2.2
rbenv global 2.2.2
ruby -v

echo "That's all folks!"


