#!/bin/bash

##########################################
## Script de pos-instalacao para uma VM ##
## de desenvolvimento rodando Ubuntu    ##
##########################################

function instala_pacotes {
    for pacote in $*
    do
        sudo apt-get -qq install $pacote
    done
}

function remove_pacotes {
    for pacote in $*
    do
        sudo apt-get -qq remove $pacote
    done
}


## Inclui usuario no sudoers, sem senha
########################################################################
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
sudo grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
    sudo echo $SUDOER_LINE | sudo tee -a /etc/sudoers.d/$USER > /dev/null
    sudo chmod 0400 /etc/sudoers.d/$USER
fi

## Configura o proxy
########################################################################
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


## Apaga alguns pacotes não-essenciais
########################################################################
remove_pacotes \
    account-plugin-facebook \
    account-plugin-twitter \
    bluez\
    brasero \
    gwibber-service-facebook \
    gwibber-service-twitter \
    rhythmbox \
    thunderbird \
    totem \
    ;

remove_pacotes \
    unity-lens-music \
    unity-lens-photos \
    unity-lens-shopping \
    unity-lens-video \
    ;


## Inclui alguns repositorios
########################################################################

#Repositorio para o Sublime Text 2
sudo -E add-apt-repository -y ppa:webupd8team/sublime-text-2

#Repositorio para ubuntu-tweak
sudo -E add-apt-repository -y ppa:tualatrix/ppa

#Repositorio para faenza-icon-theme
#sudo -E add-apt-repository -y ppa:tiheum/equinox

#Repositorio para python2.6
#sudo -E add-apt-repository -y ppa:fkrull/deadsnakes


## Instala pacotes para desenvolvimento
########################################################################

sudo apt-get -qq update
instala_pacotes \
    alien \
    build-essential \
    checkinstall \
    curl \
    git \
    libjpeg-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    mercurial \
    python-dev \
    python-pip \
    python-setuptools \
    python-virtualenv \
    rubygems \
    sublime-text \
    subversion \
    unixodbc-dev \
    vim \
    wireshark \
    xclip \
    zlib1g-dev \
    zsh \
    ;
#    python2.6-dev \

#Instala oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
chsh -s /usr/bin/zsh


## Instala pacotes para desktop ubuntu
########################################################################

instala_pacotes \
    synapse \
    ubuntu-tweak \
    gnome-tweak-tool \
    ;
#    faenza-icon-theme \


## Instala o suporte a pt_BR
########################################################################
instala_pacotes \
    hunspell-en-ca \
    hyphen-en-us \
    language-pack-gnome-pt \
    language-pack-pt \
    libreoffice-help-en-gb \
    libreoffice-help-pt \
    libreoffice-help-pt-br \
    libreoffice-l10n-en-gb \
    libreoffice-l10n-en-za \
    libreoffice-l10n-pt \
    libreoffice-l10n-pt-br \
    myspell-en-au \
    myspell-en-gb \
    myspell-en-za \
    myspell-pt \
    mythes-en-au \
    mythes-en-us \
    openoffice.org-hyphenation \
    wbrazilian \
    wbritish \
    wportuguese \
    ;

## Instala pacotes adicionais do VirtualBox
########################################################################
instala_pacotes \
    virtualbox-guest-additions-iso \
    virtualbox-guest-x11 \
    ;

## Ajustes no Desktop
########################################################################
dconf write /com/canonical/indicator/datetime/show-date true
dconf write /com/canonical/indicator/datetime/show-day true
dconf write /com/canonical/unity/lenses/remote-content-search '"none"'
#dconf write /org/gnome/desktop/interface/icon-theme '"Faenza-Ambiance"'
dconf write /com/canonical/unity/launcher/favorites '["application://nautilus.desktop", "application://chromium-browser.desktop", "application://sublime-text-2.desktop", "application://firefox.desktop", "unity://running-apps", "unity://expo-icon", "unity://devices"]'

sudo mkdir -p /var/cache/buildout/eggs
sudo mkdir -p /var/cache/buildout/dlcache
sudo -E chown -R $USER /var/cache/buildout/ -R


#Limpa cache do apt
sudo apt-get clean
