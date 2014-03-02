#!/bin/bash

INSTALA_PACOTES="sudo apt-get -q -y install "
REMOVE_PACOTES="sudo apt-get -q -y remove "

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

# Extras
$INSTALA_PACOTES \
    browser-plugin-vlc \
    calibre \
    gimp \
    inkscape \
    transmission \
    ubuntu-restricted-addons \
    ubuntu-restricted-extras \
    ;
