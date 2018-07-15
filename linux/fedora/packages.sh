#!/bin/bash
declare -A packages

packages['dev']='
    ctags-etags
    curl
    direnv
    gcc-c++
    git
    git-extras
    httpie
    libffi-devel
    libjpeg-devel
    libxml2
    libxml2-devel
    libxslt-devel
    make
    neovim
    nodejs
    npm
    p7zip
    patch
    perl
    poppler-utils
    python-devel
    python3-devel
    ranger
    ruby-devel
    tig
    tmux
    tree
    unzip
    wget
    which
    wv
    zsh
'

packages['npm']='
    browser-sync
    jshint
'

packages['python']='
    sqlite-devel
    llvm
    openssl-devel
    readline-devel
    tk-devel
'

packages['pip']='
    docker-compose
    ipython
    jupyter
    neovim
    pdbpp
    pip
    pipenv
    requests
    youtube-dl
'

packages['desktop-common']="
    'https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm'
    'https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
    chromium
"

packages['desktop-minimal']='
    feh
    i3
    lightdm
'

packages['desktop-complete']='
    amrnb
    amrwb
    faad2
    flac
    ffmpeg
    gpac-libs
    lame
    libfc14audiodecoder
    mencoder
    mplayer
    x264
    x265
    gstreamer-plugins-espeak
    gstreamer-plugins-fc
    gstreamer-rtsp
    gstreamer-plugins-good
    gstreamer-plugins-bad
    gstreamer-plugins-bad-free-extras
    gstreamer-plugins-bad-nonfree
    gstreamer-plugins-ugly
    gstreamer-ffmpeg
    gstreamer1-plugins-base
    gstreamer1-libav
    gstreamer1-plugins-bad-free-extras
    gstreamer1-plugins-bad-freeworld
    gstreamer1-plugins-base-tools
    gstreamer1-plugins-good-extras
    gstreamer1-plugins-ugly
    gstreamer1-plugins-bad-free
    gstreamer1-plugins-good

    gnome-tweak-tool

    calibre
    gimp
    inkscape
    transmission
    VirtualBox
'

export packages
