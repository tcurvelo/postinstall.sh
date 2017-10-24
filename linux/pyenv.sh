#!/bin/bash
pythons='2.7.13 3.6.2'
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

  global_envs=''
  for python in $pythons; do
    # Install each python version
    [ ! -d $HOME/.pyenv/versions/$python ] && \
        $pyenv/bin/pyenv install $python

    # Install a virtualenv for global tools
    tools="tools"${python:0:1}
    [ ! -d "$HOME/.pyenv/versions/$python/envs/$tools" ] && \
        $pyenv/bin/pyenv virtualenv $python $tools

    # Install global tools
    $HOME/.pyenv/versions/$python/envs/$tools/bin/pip install $(echo $pkgs)
    global_envs=$global_envs" "$tools
  done

  $pyenv/bin/pyenv global $pythons $global_envs
}
