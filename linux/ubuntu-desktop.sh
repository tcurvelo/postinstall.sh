#!/bin/bash

#######
## Script de pos-instalacao para uma maquina de de desenvolvimento
## rodando Ubuntu
#######################################################################
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
REMOVE_PKGS \
    account-plugin-facebook \
    account-plugin-twitter \
    unity-lens-music \
    unity-lens-photos \
    unity-lens-shopping \
    unity-lens-video \
    ;


## Instala pacotes para desenvolvimento
########################################################################

# Repositorios para o Sublime Text 3 e Java
for repo in "webupd8team/sublime-text-3" "webupd8team/java"; do
    [ -f "/etc/apt/sources.list.d/$(echo $repo | sed 's/\//-/g')-$(lsb_release -cs).list" ] || \
        sudo -E add-apt-repository -y $repo
done

UPDATE
sudo apt-get dist-upgrade


INSTALL_PKGS \
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
    poppler-utils \
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

INSTALL_PKGS \
    sublime-text-installer \
    oracle-jdk7-installer \
    icedtea-7-plugin \
    chromium-browser \
    wireshark \
    ;


## Instala o suporte a pt_BR
########################################################################
INSTALL_PKGS \
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
sudo -E chmod a+rws -R $BUILDOUT_DIR

# Limpa cache do apt
sudo apt-get clean

# Cria chave ssh
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
    eval $(ssh-agent -s)
    ssh-add
fi
