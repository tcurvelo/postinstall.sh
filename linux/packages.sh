#!/bin/bash
declare -A packages

packages['dev']='
    build-essential
    curl
    direnv
    exuberant-ctags
    git
    git-extras
    httpie
    jq
    libffi-dev
    liblzma-dev
    libxml2
    libxml2-dev
    libxml2-utils
    libxslt1-dev
    make
    mitmproxy
    neovim
    p7zip-full
    perl
    ranger
    ripgrep
    rsync
    tig
    tmux
    tree
    wget
    zsh
'

packages['npm']='
    browser-sync
    diff-so-fancy
    jshint
'

packages['python']='
    libbz2-dev
    libdb-dev
    libncurses5-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    llvm
    xz-utils
    zlib1g-dev
'

packages['pip']='
    black
    flake8
    ipdb
    ipython
    isort
    jupyterlab
    neovim
    pandas
    pip
    pylint
    requests
    scrapy
    youtube-dl
'

packages['desktop-common']='
    kitty
    network-manager-openconnect
    network-manager-openconnect-gnome
    openconnect
'

packages['desktop-minimal']='
    feh
    i3
    lightdm
'

packages['desktop-complete']='
    calibre
    gimp
    inkscape
    ubuntu-restricted-addons
    ubuntu-restricted-extras
'

export packages
