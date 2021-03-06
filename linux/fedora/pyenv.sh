#!/bin/bash
pythons=(2.7.15 3.6.5)
pyenv=$HOME/.pyenv

function PYENV_INSTALL {
  pkgs=$1
  # Install pyenv
  [ ! -d "$HOME/.pyenv" ] && \
      git clone https://github.com/yyuu/pyenv.git $pyenv

  # Install pyenv-virtualenv
  [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ] && \
      git clone https://github.com/pyenv/pyenv-virtualenv.git \
      $pyenv/plugins/pyenv-virtualenv

  global_envs=()
  for python in $pythons; do
    echo $python
    # Install each python version
    [ ! -d $HOME/.pyenv/versions/$python ] && \
        $pyenv/bin/pyenv install $python
  done

  # Install a virtualenv for global tools
  tools="tools3"
  [ ! -d "$HOME/.pyenv/versions/$python/envs/$tools" ] && \
      $pyenv/bin/pyenv virtualenv $python $tools

  # Install global tools
  $HOME/.pyenv/versions/$python/envs/$tools/bin/pip install -U $(echo $pkgs)
  global_envs+=($tools)

  $pyenv/bin/pyenv global $pythons $global_envs
}
