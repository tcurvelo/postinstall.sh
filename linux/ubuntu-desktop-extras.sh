#!/bin/bash
function INSTALL_PKGS {
    sudo apt-get -y --ignore-missing install $*
}

function REMOVE_PKGS {
    sudo apt-get -y remove $*
}

function UPDATE {
    last_update=$(stat -c %X /var/lib/apt/lists/)
    last_repo_added=$(stat -c %Y /etc/apt/sources.list* | sort -n -r | head -1)
    now=$(date +%s)
    if [ $last_update -lt $last_repo_added ] || [ $(($now-$last_update)) -gt 3600 ] ; then
        sudo apt-get -y update
    fi
}

UPDATE

# Extras
INSTALL_PKGS \
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
INSTALL_PKGS \
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

