#!/bin/bash

brew install \
      cask \
      ctags \
      direnv \
      neovim \
      readline \
      ripgrep \
      sqlite \
      tree \
      wget \
      ;

brew cask install \
      alfred \
      battle-net \
      docker \
      firefox \
      flux \
      google-chrome \
      iterm2 \
      seashore \
      spotify \
      steam \
      visual-studio-code \
      ;

brew upgrade
brew cask upgrade