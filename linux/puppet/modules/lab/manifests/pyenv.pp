class lab::pyenv($pyenv_root) {

  $python2 = "2.7.13"
  $python3 = "3.6.2"
  $python2_major = "python2.7"
  $python3_major = "python3.6"
  $pyenv_path = [
    "${pyenv_root}/bin",
    "${pyenv_root}/plugins/python-build/bin/",
    "/bin",
    "/usr/bin"
  ]
  $pyenv_env = ["PYENV_ROOT=${pyenv_root}"]

  package {
      [
        "libbz2-dev",
        "libncurses5-dev",
        "libncursesw5-dev",
        "libreadline-dev",
        "libsqlite3-dev",
        "libssl-dev",
        "llvm",
        "make",
        "tk-dev",
        "wget",
        "xz-utils",
        "zlib1g-dev",
      ]:
      ensure => installed,
  }

  exec { "pyenv-installer":
      command => "/usr/bin/git clone https://github.com/pyenv/pyenv.git ${pyenv_root}",
      creates => "${pyenv_root}"
  }

  exec { "pyenv-init":
    command => "bash -c eval $(${pyenv_root}/bin/pyenv init -)",
    path =>  [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    require => Exec["pyenv-installer"]
  }


  exec { "pyenv-virtualenv":
    command => "/usr/bin/git clone https://github.com/pyenv/pyenv-virtualenv.git ${pyenv_root}/plugins/pyenv-virtualenv",
    creates => "${pyenv_root}/plugins/pyenv-virtualenv",
    require => Exec["pyenv-installer"]
  }

  exec { "python2":
    command => "${pyenv_root}/bin/pyenv install ${python2}",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/${python2}",
    require => Exec["pyenv-init"]
  }

  exec { "tools2-init":
    command => "${pyenv_root}/bin/pyenv virtualenv ${python2} tools2",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/tools2",
    require => Exec["python2", "pyenv-virtualenv"]
  }

  exec { "tools2-pkgs":
    command => "${pyenv_root}/versions/${python2}/envs/tools2/bin/pip install neovim flake8 ipython pdbpp",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/tools2/lib/${python2_major}/site-packages/pdbpp",
    require => Exec["tools2-init"]
  }

  exec { "python3":
    command => "${pyenv_root}/bin/pyenv install ${python3}",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/${python3}",
    require => Exec["pyenv-init"]
  }

  exec { "tools3-init":
    command => "${pyenv_root}/bin/pyenv virtualenv ${python3} tools3",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/tools3",
    require => Exec["python3", "pyenv-virtualenv"]
  }

  exec { "tools3-pkgs":
    command => "${pyenv_root}/versions/${python3}/envs/tools3/bin/pip install neovim flake8 ipython pdbpp",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    creates => "${pyenv_root}/versions/tools3/lib/${python3_major}/site-packages/pdbpp",
    require => Exec["tools3-init"]
  }

  exec { "pyenv-globals":
    command => "${pyenv_root}/bin/pyenv global ${python3} ${python2} tools3 tools2",
    path => $pyenv_path,
    timeout => 0,
    environment => $pyenv_env,
    require => Exec["tools2-init", "tools3-init"]
  }

}
