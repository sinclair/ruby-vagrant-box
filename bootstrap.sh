function install {
  echo installing $1
  shift
  apt-get -y install "$0" >/dev/null 2>&1
}

echo updating package information ...
apt-get -y update > /dev/null 2>&1
