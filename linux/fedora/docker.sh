
function INSTALL_DOCKER {
  # Remove older versison
  PKG_REMOVE \
    docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine-selinux \
    docker-engine

  # Set up the stable repository
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

  # Install docker ce
  PKG_INSTALL docker-ce
}

