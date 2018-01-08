#!/bin/bash
declare -A packages

packages['dev']='
    build-essential
    curl
    docker-compose
    docker.io
    exuberant-ctags
    git
    git-extras
    httpie
    libffi-dev
    libxml2
    libxml2-dev
    libxml2-utils
    libxslt1-dev
    make
    neovim
    nodejs
    npm
    p7zip-full
    perl
    python-dev
    python-tk
    python3-dev
    ranger
    ruby-dev
    tig
    tmux
    tree
    wget
    wrk
    zsh
'

packages['npm']='
    browser-sync
    grunt-cli
    jshint
'

packages['python']='
    libbz2-dev
    libncurses5-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    llvm
    tk-dev
    xz-utils
    zlib1g-dev
'

packages['pip']='
    docker-compose
    ipython
    neovim
    pdbpp
'

packages['desktop-common']='
    chromium-browser
    konsole
    wireshark
'

packages['desktop-minimal']='
    feh
    i3
    lightdm
'

packages['desktop-complete']='
    calibre
    gimp
    icedtea-7-plugin
    inkscape
    oracle-jdk7-installer
    synapse
    transmission
    ubuntu-restricted-addons
    ubuntu-restricted-extras
    virtualbox
'

export packages
