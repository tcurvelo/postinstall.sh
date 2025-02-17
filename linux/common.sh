#!/bin/bash

which sudo > /dev/null && SUDO=sudo

## Common functions
########################################################################
function APT_UPDATE {
    last_update=$(stat -c %X /var/lib/apt/lists/)
    last_repo_added=$(stat -c %Y /etc/apt/sources.list* | sort -n -r | head -1)
    now=$(date +%s)
    if [ $last_update -lt $last_repo_added ] || [ $(($now-$last_update)) -gt 3600 ] ; then
        $SUDO apt-get -y update
    fi
}

function APT_INSTALL {
  APT_UPDATE
  $SUDO apt-get -y --ignore-missing install $(echo $*)
}

function APT_REMOVE {
  $SUDO apt-get -y remove $(echo $*)
}

function APT_CLEAN {
  $SUDO apt autoremove -y;
  $SUDO apt clean;
}

function SNAP_INSTALL {
  for pkg in $(echo $*); do
    $SUDO snap install $pkg --classic
  done
}

function UPDATE_LOCALES() {
  APT_INSTALL locales \
    && $SUDO locale-gen --purge \
       en_US en_US.utf8 \
       pt_BR pt_BR.utf8 \
    && $SUDO dpkg-reconfigure --unseen locales
}

function ENABLE_SUDO() {
  [ "$SUDO" == "" ] && return 1
  SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
  $SUDO grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
  if [ $? -ne 0 ]; then
      echo $SUDOER_LINE | $SUDO tee -a /etc/sudoers.d/$USER > /dev/null
      $SUDO chmod 0400 /etc/sudoers.d/$USER
  fi
}

function CREATE_SSH_KEY() {
  if [ ! -f ~/.ssh/id_rsa.pub ]; then
      mkdir -p ~/.ssh
      ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
      eval $(ssh-agent -s)
      ssh-add
  fi
}
