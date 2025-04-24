#!/bin/bash
source common.sh
source packages.sh
source python.sh
source chrome.sh
source k8s.sh
source hashicorp.sh

ENABLE_SUDO
UPDATE_LOCALES
CREATE_SSH_KEY

APT_INSTALL ${packages['dev']} ${packages['python']}
PYTHON_TOOLS_INSTALL ${packages['pip']}
INSTALL_K8S_TOOLS
INSTALL_HASHICORP_TOOLS

case $1 in
  desktop-*)
    source docker.sh
    APT_INSTALL ${packages['desktop-common']}
    SNAP_INSTALL ${packages['desktop-common-snap']}
    INSTALL_DOCKER
    INSTALL_CHROME
    case $1 in
      desktop-minimal) APT_INSTALL ${packages['desktop-minimal']};;
      desktop-complete) APT_INSTALL ${packages['desktop-complete']};;
    esac
esac

APT_CLEAN

