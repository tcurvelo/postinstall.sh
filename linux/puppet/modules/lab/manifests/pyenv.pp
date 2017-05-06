class lab::pyenv($pyenv_root) {

  exec { "pyenv-installer":
      command => "/usr/bin/git clone https://github.com/pyenv/pyenv.git ${pyenv_root}",
      creates => "${pyenv_root}"
  }

  exec { "pyenv-init":
    command => "bash -c eval $(${pyenv_root}/bin/pyenv init -)",
    path =>  [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    require => Exec["pyenv-installer"]
  }

  exec { "python2":
    command => "${pyenv_root}/bin/pyenv install 2.7.13",
    path => ["${pyenv_root}/bin", "${pyenv_root}/plugins/python-build/bin/", "/bin", "/usr/bin"],
    timeout => 0,
    environment => ["PYENV_ROOT=${pyenv_root}"],
    creates => "${pyenv_root}/versions/2.7.13",
    require => Exec["pyenv-init"]
  }

  exec { "python3":
    command => "${pyenv_root}/bin/pyenv install 3.6.1",
    path => ["${pyenv_root}/bin", "${pyenv_root}/plugins/python-build/bin/", "/bin", "/usr/bin"],
    timeout => 0,
    environment => ["PYENV_ROOT=${pyenv_root}"],
    creates => "${pyenv_root}/versions/3.6.1",
    require => Exec["pyenv-init"]
  }

  exec { "pyenv-virtualenv":
    command => "/usr/bin/git clone https://github.com/pyenv/pyenv-virtualenv.git ${pyenv_root}/plugins/pyenv-virtualenv",
    creates => "${pyenv_root}/plugins/pyenv-virtualenv",
    require => Exec["pyenv-installer"]
  }

}
