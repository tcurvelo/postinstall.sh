#!/bin/bash
source common.sh
source packages.sh
source pyenv.sh
source docker.sh
source vscode.sh

ENABLE_SUDO
UPDATE_LOCALES
CREATE_SSH_KEY

APT_INSTALL ${packages['dev']} ${packages['python']}
PYENV_INSTALL ${packages['pip']}
NPM_INSTALL ${packages['npm']}

case $1 in
  desktop-*)
    APT_INSTALL ${packages['desktop-common']}
    INSTALL_DOCKER
    INSTALL_CODE
    case $1 in
      desktop-minimal) APT_INSTALL ${packages['desktop-minimal']};;
      desktop-complete) APT_INSTALL ${packages['desktop-complete']};;
    esac
esac
