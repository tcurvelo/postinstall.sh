class lab::ubuntu {

  package {
      [
        "build-essential",
        "curl",
        "docker-compose",
        "docker.io",
        "exuberant-ctags",
        "git",
        "git-extras",
        "httpie",
        "neovim",
        "nodejs",
        "p7zip-full",
        "ranger",
        "ruby-dev",
        "tig",
        "tmux",
        "wrk",
        "zsh"
      ]:
      ensure => installed,
  }

  class { 'locales':
    default_locale  => 'pt_BR.UTF-8',
    locales   => ['en_US.UTF-8 UTF-8', 'pt_BR.UTF-8 UTF-8'],
  }

}
