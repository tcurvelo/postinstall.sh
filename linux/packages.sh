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
    libffi-dev
    libxml2
    libxml2-dev
    libxml2-utils
    libxslt1-dev
    make
    neovim
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
    zsh
'

packages['npm']='
    browser-sync
    diff-so-fancy
    grunt-cli
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
    tk-dev
    xz-utils
    zlib1g-dev
'

packages['pip']='
    black
    docker-compose
    flake8
    ipython
    isort
    jupyter
    jupyterlab
    neovim
    pandas
    pdbpp
    pip
    pipenv
    pylint
    requests
    scrapy
    youtube-dl
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
    inkscape
    synapse
    transmission
    ubuntu-restricted-addons
    ubuntu-restricted-extras
    virtualbox
'

export packages
