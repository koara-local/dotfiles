#!/bin/bash

PACKAGES=( \
  meld \
  git  \
  gitg \
  tree \
  terminator \
  gcc \
  gcc-c++ \
  kernel-devel \
)

for package in ${PACKAGES[@]}
do
  sudo yum install -y $package
done
