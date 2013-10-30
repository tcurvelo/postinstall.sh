#!/bin/bash

# Dropbox
sudo apt-get -qq install \
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
sudo apt-get -qq install \
    lib32asound2 \
    lib32z1 \
    nspluginwrapper \
    ;

# Extras
sudo apt-get -qq install
    browser-plugin-vlc \
    calibre \
    gimp \
    inkscape \
    transmission \
    ubuntu-restricted-addons \
    ubuntu-restricted-extras \
    ;
