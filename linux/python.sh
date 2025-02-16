#!/bin/bash
pythons=(3.13 3.12 3.11)

function PYTHON_TOOLS_INSTALL() {
  # install uv
  if ! which uv >/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi

  # install some python versions
  for python in ${pythons[@]}; do
    uv python install $python
  done

  # install tools
  pkgs=$1
  for tool in $(echo $pkgs); do
    uv tool install $tool
  done
}
