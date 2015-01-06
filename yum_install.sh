#!/bin/bash

PACKAGES=( \
  zsh \
  meld \
  git  \
  gitg \
  tree \
  xsel \
  terminator \
  gcc \
  gcc-c++ \
  clang \
  kernel-devel \
)

for package in ${PACKAGES[@]}
do
  sudo yum install -y $package
done
