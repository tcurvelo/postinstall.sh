#!/bin/bash

function INSTALL_VSCODE {

    [ ! -f /etc/yum.repos.d/vscode.repo ] && \
    cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo >> /dev/null
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc"
EOF

    PKG_INSTALL code
}
