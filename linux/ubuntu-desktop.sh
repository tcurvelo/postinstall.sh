#!/bin/bash

#######
## Script de pos-instalacao para uma maquina de de desenvolvimento
## rodando Ubuntu
#######################################################################

INSTALA_PACOTES="sudo apt-get -q -y --ignore-missing install "
REMOVE_PACOTES="sudo apt-get -q -y remove "


## Inclui usuario no sudoers, sem senha
########################################################################
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
sudo grep "$SUDOER_LINE" /etc/sudoers.d/$USER > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
    sudo echo $SUDOER_LINE | sudo tee -a /etc/sudoers.d/$USER > /dev/null
    sudo chmod 0400 /etc/sudoers.d/$USER
fi


## Apaga alguns pacotes não-essenciais
########################################################################
$REMOVE_PACOTES \
    account-plugin-facebook \
    account-plugin-twitter \
    unity-lens-music \
    unity-lens-photos \
    unity-lens-shopping \
    unity-lens-video \
    ;


## Instala pacotes para desenvolvimento
########################################################################

# Repositorio para o Sublime Text 3
sudo -E add-apt-repository -y ppa:webupd8team/sublime-text-3

# Repositorio para o plugin do java
sudo -E add-apt-repository -y ppa:webupd8team/java

sudo apt-get -qq update
sudo apt-get dist-upgrade


$INSTALA_PACOTES \
    alien \
    build-essential \
    checkinstall \
    curl \
    git \
    git-extras \
    libaio1 \
    libffi-dev \
    libjpeg-dev \
    libpcre3-dev \
    libreadline-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    mercurial \
    p7zip-full \
    python-dev \
    python-pip \
    python-setuptools \
    python-virtualenv \
    python3-dev \
    ranger \
    subversion \
    terminator \
    unixodbc-dev \
    vim \
    zlib1g-dev \
    zsh \
    ;

$INSTALA_PACOTES \
    sublime-text-installer \
    oracle-jdk7-installer \
    icedtea-7-plugin \
    chromium-browser \
    wireshark \
    ;

# Instala oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
    chsh -s /usr/bin/zsh
fi

## Instala o suporte a pt_BR
########################################################################
$INSTALA_PACOTES \
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


## Ajustes no Desktop
########################################################################
dconf write /com/canonical/indicator/datetime/show-date true
dconf write /com/canonical/indicator/datetime/show-day true
dconf write /com/canonical/unity/lenses/remote-content-search '"none"'
dconf write /com/canonical/unity/launcher/favorites '["application://chromium-browser.desktop", "application://firefox.desktop", "application://terminator.desktop", "application://sublime-text.desktop", "application://nautilus.desktop", "unity://running-apps", "unity://expo-icon", "unity://devices"]'

# Cria diretorios para cache do buildout
BUILDOUT_DIR=/var/cache/buildout
sudo mkdir -p $BUILDOUT_DIR/{eggs,dlcache}
sudo -E chown -R root.sudo $BUILDOUT_DIR
sudo -E chmod g+rws -R $BUILDOUT_DIR

# Limpa cache do apt
sudo apt-get clean

# Cria chave ssh
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
    ssh-add
fi

