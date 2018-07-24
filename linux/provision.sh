#!/bin/bash
source common.sh
source packages.sh
source pyenv.sh
source docker.sh

ENABLE_SUDO
UPDATE_LOCALES
CREATE_SSH_KEY

APT_INSTALL ${packages['dev']} ${packages['python']}
PYENV_INSTALL ${packages['pip']}
NPM_INSTALL ${packages['npm']}

case $1 in
  desktop-minimal)
    APT_INSTALL ${packages['desktop-common']} ${packages['desktop-minimal']}
    INSTALL_DOCKER
    ;;
  desktop-complete)
    APT_INSTALL ${packages['desktop-common']} ${packages['desktop-complete']}
    INSTALL_DOCKER
    ;;
esac
