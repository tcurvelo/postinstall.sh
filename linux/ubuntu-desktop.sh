#!/bin/bash

########################################################################
## Postinstall script for a ubuntu desktop box
########################################################################
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
    if [ $last_update -lt $last_repo_added ] || \
       [ $(($now-$last_update)) -gt 3600 ] ; then
        sudo apt-get -y update
    fi
}

## Drop some unnecessary pkgs
########################################################################
REMOVE_PKGS \
    account-plugin-facebook \
    account-plugin-twitter \
    unity-lens-music \
    unity-lens-photos \
    unity-lens-shopping \
    unity-lens-video \
    ;

## Install some extra pkgs
########################################################################
# Repos for Sublime, Java & faenza icons
for repo in \
  "webupd8team/sublime-text-3" \
  "webupd8team/java" \
  "webupd8team/themes"; do
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
    vim-gtk \
    wireshark \
    ;

## Installs pt_BR support
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

## Desktop tweaks
########################################################################
dconf write /com/canonical/indicator/datetime/show-date true
dconf write /com/canonical/indicator/datetime/show-day true
dconf write /com/canonical/unity/lenses/remote-content-search '"none"'
dconf write /com/canonical/unity/launcher/favorites '["application://chromium-browser.desktop", "application://firefox.desktop", "application://terminator.desktop", "application://sublime-text.desktop", "application://nautilus.desktop", "unity://running-apps", "unity://expo-icon", "unity://devices"]'

# Cleanup
sudo apt-get clean

