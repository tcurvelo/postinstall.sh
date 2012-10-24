#!/bin/bash

##########################################
## Script de pos-instalacao para uma VM ##
## de desenvolvimento rodando Ubuntu    ##
##########################################

sudo echo "$USER    ALL=(ALL)   NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USER > /dev/null
sudo chmod 0400 /etc/sudoers.d/$USER

AUTH_INPUT=$(zenity --username --password)

if [ "$AUTH_INPUT" != "" ]
then
    LOGIN=$(echo $AUTH_INPUT | cut -d '|' -f1)
    SENHA=$(echo $AUTH_INPUT | cut -d '|' -f2)
    PROXY_HOST=10.13.10.250
    PROXY_PORT=8080

    PROXY_URL=http://$LOGIN:$SENHA@$PROXY_HOST:$PROXY_PORT/

    #Configura proxy para apt e http
    sudo -S bash -c 'cat > /etc/apt/apt.conf.d/00proxy' << EOF
    Acquire{
        ftp::Proxy "$PROXY_URL";
        http::Proxy "$PROXY_URL";
        https::Proxy "$PROXY_URL";
    }
EOF

    sudo cat >> ~/.profile << EOF 
export ftp_proxy="$PROXY_URL";
export http_proxy="$PROXY_URL";
export https_proxy="$PROXY_URL";
EOF

    #Configura proxy para subversion
    mkdir ~/.subversion/
    cat > ~/.subversion/servers << EOF
http-proxy-host = $PROXY_HOST
http-proxy-port = $PROXY_PORT
http-proxy-username = $LOGIN
http-proxy-password = $SENHA
EOF

    export ftp_proxy="$PROXY_URL";
    export http_proxy="$PROXY_URL";
    export https_proxy="$PROXY_URL";

fi

#Apaga alguns pacotes não-essenciais
sudo apt-get -y remove rhythmbox brasero totem thunderbird bluez 
sudo apt-get -y remove gwibber-service-twitter gwibber-service-facebook \
account-plugin-twitter account-plugin-facebook 
sudo apt-get -y remove unity-lens-music unity-lens-photos \
unity-scope-home unity-lens-video

#Repositorio para o Sublime Text 2
sudo -E add-apt-repository -y ppa:webupd8team/sublime-text-2

#Repositorio para ubuntu-tweak
sudo -E add-apt-repository -y ppa:tualatrix/ppa

#Repositorio para faenza-icon-theme
sudo -E add-apt-repository -y ppa:tiheum/equinox

#Repositorio para python2.6
sudo -E add-apt-repository -y ppa:fkrull/deadsnakes

sudo apt-get -y update
sudo apt-get -y install alien build-essential checkinstall curl faenza-icon-theme git gnome-tweak-tool \
guake libjpeg-dev libsasl2-dev libxml2-dev libxslt1-dev mercurial python2.6-dev python-dev python-pip \
python-setuptools python-virtualenv rubygems sublime-text-2-beta subversion synapse ubuntu-tweak 
unixodbc-dev vim wireshark xclip zlib1g-dev zsh 


curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash

#Instala o suporte a pt_BR
sudo apt-get -y install language-pack-pt language-pack-gnome-pt hunspell-en-ca hyphen-en-us \
libreoffice-help-en-gb libreoffice-help-pt libreoffice-help-pt-br \
libreoffice-l10n-en-gb libreoffice-l10n-en-za libreoffice-l10n-pt libreoffice-l10n-pt-br \
myspell-en-au myspell-en-gb myspell-en-za myspell-pt mythes-en-au mythes-en-us \
openoffice.org-hyphenation wbrazilian wbritish wportuguese

#Instala pacotes adicionais do VirtualBox
sudo apt-get -y install virtualbox-guest-additions virtualbox-guest-x11

#Limpa cache do apt
sudo apt-get clean

chsh -s /usr/bin/zsh

#Ajustes de Desktop
dconf write /com/canonical/indicator/datetime/show-date true
dconf write /com/canonical/indicator/datetime/show-day true
dconf write /com/canonical/unity/lenses/remote-content-search '"none"'
dconf write /org/gnome/desktop/interface/icon-theme '"Faenza-Ambiance"'
dconf write /com/canonical/unity/launcher/favorites '["application://nautilus.desktop", "application://chromium-browser.desktop", "application://sublime-text-2.desktop", "application://firefox.desktop", "unity://running-apps", "unity://expo-icon", "unity://devices"]'

sudo mkdir -p /var/cache/buildout/eggs
sudo mkdir -p /var/cache/buildout/dlcache
sudo -E chown -R $USER /var/cache/buildout/ -R


