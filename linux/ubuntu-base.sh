#!/bin/bash

########################################################################
## Postinstall base script for a ubuntu box
########################################################################
function INSTALL_PKGS {
    sudo apt-get --yes --ignore-missing install $*
}

function REMOVE_PKGS {
    sudo apt-get --yes remove $*
}

function UPDATE {
    last_update=$(stat -c %X /var/lib/apt/lists/)
    last_repo_added=$(stat -c %Y /etc/apt/sources.list* | sort -n -r | head -1)
    now=$(date +%s)
    if [ $last_update -lt $last_repo_added ] || \
       [ $(($now-$last_update)) -gt 3600 ] ; then
           sudo apt-get -y update
    fi
}

## Allows sudo
########################################################################
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
sudo grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
    echo $SUDOER_LINE | sudo tee -a /etc/sudoers.d/$USER > /dev/null
    sudo chmod 0400 /etc/sudoers.d/$USER
fi

## Installs devs pkgs
########################################################################
for repo in \
  "chris-lea/node.js"; do
    [ -f "/etc/apt/sources.list.d/$(echo $repo | sed 's/\//-/g')-$(lsb_release -cs).list" ] || \
        sudo -E add-apt-repository -y ppa:$repo
done

UPDATE
sudo apt-get dist-upgrade --yes

INSTALL_PKGS \
    alien \
    build-essential \
    checkinstall \
    cmake \
    curl \
    exuberant-ctags \
    git \
    git-extras \
    libaio1 \
    libffi-dev \
    libjpeg-dev \
    libldap2-dev \
    libpcre3-dev \
    libpq-dev \
    libreadline-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    p7zip-full \
    poppler-utils \
    python-dev \
    python-flake8 \
    python-pip \
    python-setuptools \
    python-virtualenv \
    python3-dev \
    ranger \
    silversearcher-ag \
    vim \
    zlib1g-dev \
    zsh \
    ;

sudo ln -sf /usr/bin/nodejs /usr/bin/node

sudo -E npm install -g \
  grunt-cli \
  jshint \
  jsctags \
  ;

## Misc
########################################################################
## Fix locale
INSTALL_PKGS --reinstall locales \
   && sudo localedef -v -c -i pt_BR -f UTF-8 pt_BR.UTF-8 \
   && sudo dpkg-reconfigure locales \
   ;

## Create buildout cache
BUILDOUT_DIR=/var/cache/buildout
sudo mkdir -p $BUILDOUT_DIR/{eggs,dlcache}
sudo -E chown -R root.sudo $BUILDOUT_DIR
sudo -E chmod a+rws -R $BUILDOUT_DIR

## Create ssh key
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
    eval $(ssh-agent -s)
    ssh-add
fi

## Clean cache
sudo apt-get clean
