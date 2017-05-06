class lab::ubuntu {

  package {
      [
        "build-essential",
        "cmake",
        "curl",
        "exuberant-ctags",
        "git",
        "git-extras",
        "httpie",
        "libaio1",
        "libffi-dev",
        "libjpeg-dev",
        "libldap2-dev",
        "libpcre3-dev",
        "libpq-dev",
        "libreadline-dev",
        "libsasl2-dev",
        "libssl-dev",
        "libxml2-dev",
        "libxslt1-dev",
        "lolcat",
        "neovim",
        "p7zip-full",
        "poppler-utils",
        "python-dev",
        "python-flake8",
        "python-pip",
        "python-setuptools",
        "python-tk",
        "python3-dev",
        "python3-pip",
        "ranger",
        "ruby-dev",
        "silversearcher-ag",
        "tig",
        "tmux",
        "wrk",
        "zlib1g-dev",
        "zsh"
      ]:
      ensure => installed,
  }

  class { 'locales':
    default_locale  => 'pt_BR.UTF-8',
    locales   => ['en_US.UTF-8 UTF-8', 'pt_BR.UTF-8 UTF-8'],
  }

}
