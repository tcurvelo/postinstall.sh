#!/bin/bash

## Common functions
########################################################################
function PKG_INSTALL {
    sudo dnf -y --skip-broken install $(echo $*)
}

function PKG_REMOVE {
    sudo dnf -y remove $(echo $*)
}

function NPM_INSTALL {
    sudo npm install -g  $(echo $*)
}

function ENABLE_SUDO {
  SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
  sudo grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
  if [ $? -ne 0 ]; then
      echo $SUDOER_LINE | sudo tee -a /etc/sudoers.d/$USER > /dev/null
      sudo chmod 0400 /etc/sudoers.d/$USER
  fi
}

function CREATE_SSH_KEY {
  if [ ! -f ~/.ssh/id_rsa.pub ]; then
      mkdir -p ~/.ssh
      ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
      eval $(ssh-agent -s)
      ssh-add
  fi
}
