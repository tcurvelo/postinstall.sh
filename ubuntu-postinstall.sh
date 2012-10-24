#!/bin/bash
##
## Post-install script for an Ubuntu enviroment
##

#TODO:
# * install Skype
# * install Citrix Receiver
#   ==> http://www.citrix.com/downloads/citrix-receiver/receivers-by-platform/receiver-for-linux-121.html#ctx-dl-eula
# * dotfiles
# * chrome(ium) and firefox sync
# * setting wallpaper
# * directories 

sudo echo "$USER    ALL=(ALL)   NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USER > /dev/null
sudo chmod 0400 /etc/sudoers.d/$USER

# rip off some undesired packages
sudo apt-get -y remove unity-lens-music unity-lens-photos \
unity-scope-home unity-lens-video


# sublime Text 2
sudo -E add-apt-repository -y ppa:webupd8team/sublime-text-2
# ubuntu-tweak
sudo -E add-apt-repository -y ppa:tualatrix/ppa
# faenza-icon-theme
sudo -E add-apt-repository -y ppa:tiheum/equinox

sudo apt-get -y update
sudo apt-get -y install alien build-essential checkinstall curl \
faenza-icon-theme git guake libsasl2-dev libxml2-dev libxslt1-dev mercurial \
python-dev python-pip python-setuptools python-virtualenv rubygems \
sublime-text-2-beta subversion synapse vim virtualbox wireshark xclip \
zlib1g-dev zsh

#citrix dependencies
sudo apt-get -y install lib32asound2 lib32z1 nspluginwrapper

sudo gem install vagrant

sudo apt-get -y install browser-plugin-vlc calibre chromium-browser gimp \
gnome-tweak-tool inkscape transmission ubuntu-restricted-addons \
ubuntu-restricted-extras ubuntu-tweak unity-tweak-tool vlc

# installs oh-my-zsh
curl -L http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash

# changes default shell
chsh -s /usr/bin/zsh

sudo mkdir -p /var/cache/buildout/eggs
sudo mkdir -p /var/cache/buildout/dlcache
sudo -E chown -R $USER /var/cache/buildout/ -R



# pt_BR support
sudo apt-get -y install language-pack-pt language-pack-gnome-pt \
hunspell-en-ca hyphen-en-us libreoffice-help-en-gb \
libreoffice-help-pt libreoffice-help-pt-br libreoffice-l10n-en-gb \
libreoffice-l10n-en-za libreoffice-l10n-pt libreoffice-l10n-pt-br \
myspell-en-au myspell-en-gb myspell-en-za myspell-pt mythes-en-au \
mythes-en-us openoffice.org-hyphenation wbrazilian wbritish wportuguese

# dropbox
sudo apt-get install python-gpgme
wget -c 'https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb' -O dropbox.deb
sudo dpkg -i dropbox.deb && rm dropbox.deb

# hangouts plugin
wget -c 'https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb' -O gtalk.deb
sudo dpkg -i gtalk.deb && rm gtalk.deb

# cleans apt cache
sudo apt-get clean

# desktop tweaks
dconf write /com/canonical/indicator/datetime/show-date true
dconf write /com/canonical/indicator/datetime/show-day true
dconf write /com/canonical/unity/lenses/remote-content-search '"none"'
dconf write /org/gnome/desktop/interface/icon-theme '"Faenza-Ambiance"'
dconf write /com/canonical/unity/launcher/favorites '["application://nautilus.desktop", "application://chromium-browser.desktop", "application://sublime-text-2.desktop", "application://firefox.desktop", "unity://running-apps", "unity://expo-icon", "unity://devices"]'

# create ssh key
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
ssh-add
