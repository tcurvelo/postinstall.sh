#!/bin/bash
########################################################################
## Pre-provisioning script
########################################################################

## Allows sudo
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
sudo grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
    echo $SUDOER_LINE | sudo tee -a /etc/sudoers.d/$USER > /dev/null
    sudo chmod 0400 /etc/sudoers.d/$USER
fi

## Ansible requires sshd
sudo apt-get install openssh-server

## Creates a ssh key
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
    eval $(ssh-agent -s)
    ssh-add
fi
