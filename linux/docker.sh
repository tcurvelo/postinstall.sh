
function INSTALL_DOCKER {
  APT_UPDATE
  # remove old docker packages
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove $pkg;
  done

  # install required packages
  APT_INSTALL \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common

  # Add Docker’s official GPG key:
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

  # Set up the stable repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install docker ce
  APT_UPDATE
  APT_INSTALL docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

