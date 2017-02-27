#!/bin/bash -xeu

declare -a info=($(../../bin/get_os_info))

case ${info[0]} in
ubuntu)
    echo "ubuntu"

    sudo apt-get install \
        libcurl4-openssl-dev \
        libexpat1-dev 

    ;;
*)
    echo "unsupported"
    exit 1
    ;;
esac

if [ ! -d git-master ]; then
  wget https://github.com/git/git/archive/master.zip
  unzip master.zip
fi

cd git-master/

make prefix=/usr/local all
sudo make prefix=/usr/local install
