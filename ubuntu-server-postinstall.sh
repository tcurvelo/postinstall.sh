#!/bin/bash

#Repositorio para python2.6
# sudo -E add-apt-repository -y ppa:fkrull/deadsnakes
# sudo apt-get -y install python2.6-dev 

sudo apt-get install --reinstall locales && sudo dpkg-reconfigure locales

sudo apt-get -y update
sudo apt-get -y install alien build-essential checkinstall curl git \
libsasl2-dev libxml2-dev libxslt1-dev \
mercurial npm python-dev python-pip python-setuptools \
python-virtualenv rubygems subversion vim zlib1g-dev zsh 

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash

#Instala o suporte a pt_BR
# sudo apt-get -y install language-pack-pt language-pack-gnome-pt hunspell-en-ca hyphen-en-us \
# libreoffice-help-en-gb libreoffice-help-pt libreoffice-help-pt-br \
# libreoffice-l10n-en-gb libreoffice-l10n-en-za libreoffice-l10n-pt libreoffice-l10n-pt-br \
# myspell-en-au myspell-en-gb myspell-en-za myspell-pt mythes-en-au mythes-en-us \
# openoffice.org-hyphenation wbrazilian wbritish wportuguese


#Limpa cache do apt
sudo apt-get clean

chsh -s /usr/bin/zsh

sudo mkdir -p /var/cache/buildout/eggs
sudo mkdir -p /var/cache/buildout/dlcache
sudo -E chown -R $USER /var/cache/buildout/ -R
