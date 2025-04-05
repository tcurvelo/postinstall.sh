#!/bin/bash


function INSTALL_CHROME {
  if ! command -v google-chrome > /dev/null; then
    curl -sLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
      && sudo dpkg -i google-chrome-stable_current_amd64.deb;
  fi;
}

