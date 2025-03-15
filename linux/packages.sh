#!/bin/bash
declare -A packages

packages['dev']='
    build-essential
    curl
    dbeaver-ce
    direnv
    exuberant-ctags
    git
    git-delta
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
    unzip
    wget
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
'

packages['python']='
    libbz2-dev
    libdb-dev
    libncurses-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    llvm
    xz-utils
    zlib1g-dev
'

packages['pip']='
    ipdb
    jupyterlab
    pandas
    pip-tools
    pipenv
    poetry
    ruff
    scrapy
    yt-dlp
'

packages['desktop-common']='
    kitty
    network-manager-openconnect
    network-manager-openconnect-gnome
    openconnect
'

packages['desktop-common-snap']='
    bitwarden
    code
    obsidian
    slack
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
