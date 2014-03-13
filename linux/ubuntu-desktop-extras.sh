#!/bin/bash

INSTALA_PACOTES="sudo apt-get -q -y install "
REMOVE_PACOTES="sudo apt-get -q -y remove "

# Extras
$INSTALA_PACOTES \
    browser-plugin-vlc \
    calibre \
    gimp \
    inkscape \
    transmission \
    ubuntu-restricted-addons \
    ubuntu-restricted-extras \
    virtualbox \
    ;

# Dropbox
$INSTALA_PACOTES \
    python-gpgme
wget -c \
    'https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb' \
    -O dropbox.deb
sudo dpkg -i dropbox.deb && rm dropbox.deb

# Hangouts
wget -c \
    'https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb' \
    -O gtalk.deb
sudo dpkg -i gtalk.deb && rm gtalk.deb

# Citrix
$INSTALA_PACOTES \
    lib32asound2 \
    lib32z1 \
    nspluginwrapper \
    ;

# Vagrant
wget -c \
    'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.0_x86_64.deb' \
    -O vagrant.deb
sudo dpkg -i vagrant.deb && rm vagrant.deb

