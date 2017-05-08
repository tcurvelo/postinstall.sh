class lab::ubuntu {

  package {
      [
        "build-essential",
        "curl",
        "exuberant-ctags",
        "git",
        "git-extras",
        "httpie",
        "lolcat",
        "neovim",
        "p7zip-full",
        "poppler-utils",
        "ranger",
        "ruby-dev",
        "silversearcher-ag",
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
