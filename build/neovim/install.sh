#!/bin/bash -xeu

declare -a info=($(../../bin/get_os_info))

# Installing Neovim
# https://github.com/neovim/neovim/wiki/Installing-Neovim
case ${info[0]} in
ubuntu)
    echo "ubuntu"

    sudo apt-get install software-properties-common
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim

    ;;
*)
    echo "unsupported"
    exit 1
    ;;
esac
