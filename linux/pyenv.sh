#!/bin/bash
pythons=(3.10.4)
favorite_version=3.9.6
pyenv=$HOME/.pyenv

function PYENV_INSTALL() {
  pkgs=$1
  # Install pyenv
  [ ! -d "$HOME/.pyenv" ] && \
      git clone https://github.com/yyuu/pyenv.git $pyenv

  # Install pyenv-virtualenv
  [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ] && \
      git clone https://github.com/pyenv/pyenv-virtualenv.git \
      $pyenv/plugins/pyenv-virtualenv

  global_envs=()
  for python in ${pythons[@]}; do
    # Install each python version
    [ ! -d ¨"$HOME/.pyenv/versions/$python" ] && \
        $pyenv/bin/pyenv install $python
  done

  # Install a virtualenv for global tools based on the *FIRST* python version
  tools="tools"
  [ ! -d "$HOME/.pyenv/versions/$favorite_version/envs/$tools" ] && \
      $pyenv/bin/pyenv virtualenv $favorite_version $tools

  # Install global tools
  $HOME/.pyenv/versions/$favorite_version/envs/$tools/bin/pip install -U $(echo $pkgs)
  global_envs+=($tools)

  $pyenv/bin/pyenv global ${pythons[@]} $global_envs
}
