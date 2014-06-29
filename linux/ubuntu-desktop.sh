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
for repo in "webupd8team/sublime-text-3" "webupd8team/java" "webupd8team/themes"; do
    [ -f "/etc/apt/sources.list.d/$(echo $repo | sed 's/\//-/g')-$(lsb_release -cs).list" ] || \
        sudo -E add-apt-repository -y $repo
done

UPDATE

INSTALL_PKGS \
    chromium-browser \
    faenza-icon-theme \
    icedtea-7-plugin \
    oracle-jdk7-installer \
    sublime-text-installer \
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

# Limpa cache do apt
sudo apt-get clean

