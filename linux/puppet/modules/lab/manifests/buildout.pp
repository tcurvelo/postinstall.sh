class lab::buildout($home) {
  $buildout_dir = "$home/.buildout"

  $dirs = [
    "$buildout_dir",
    "$buildout_dir/eggs",
    "$buildout_dir/dlcache",
  ]

  file { $dirs:
      ensure => "directory",
  }

  file { "$buildout_dir/default.cfg":
    ensure  => file,
    content => epp("lab/buildout.epp", {"buildout_dir" => "$buildout_dir"}),
  }

}
