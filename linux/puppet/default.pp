node default {
  $home = "/home/tcurvelo"

  include lab::ubuntu

  class {"lab::buildout":
    home  => $home
  }

  class {"lab::pyenv":
    pyenv_root => "${home}/.pyenv"
  }
}
