node default {
  $home = "/home/ubuntu"

  include lab::ubuntu

  class {"lab::pyenv":
    pyenv_root => "${home}/.pyenv"
  }

  class {"lab::buildout":
    home  => $home
  }

}
