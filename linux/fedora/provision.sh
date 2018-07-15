#!/bin/bash
source common.sh
source packages.sh
source pyenv.sh
source docker.sh
source vscode.sh

ENABLE_SUDO
CREATE_SSH_KEY

PKG_INSTALL ${packages['dev']} ${packages['python']}
PYENV_INSTALL ${packages['pip']}
NPM_INSTALL ${packages['npm']}

case $1 in
  desktop*)
    PKG_INSTALL ${packages['desktop-common']}
    INSTALL_DOCKER
    INSTALL_VSCODE
    case $1 in
      desktop-minimal) PKG_INSTALL ${packages['desktop-minimal']};;
      desktop-complete) PKG_INSTALL ${packages['desktop-complete']};;
    esac
    ;;
esac
