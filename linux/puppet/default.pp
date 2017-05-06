node default {
  class {'lab::pyenv':
    pyenv_root => '/home/ubuntu/.pyenv'
  }
  include lab::ubuntu

}
