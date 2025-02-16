#!/bin/bash
pythons=(3.13 3.12 3.11)

function PYTHON_TOOLS_INSTALL() {
  # install uv
  if ! which uv >/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi
  UV=$HOME/.local/bin/uv

  # install some python versions
  for python in ${pythons[@]}; do
    $UV python install $python
  done

  # install tools
  pkgs=$1
  for tool in $(echo $pkgs); do
    $UV tool install $tool
  done
}
