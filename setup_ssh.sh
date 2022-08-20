#! /bin/bash

# exit if any command fails
set -e

# create keys 
cd ~
ssh-keygen -t ed25519 -C "isakov.m@gmail.com"

# start agent
eval "$(ssh-agent -s)"

# add keys 
ssh-add ~/.ssh/id_ed25519
