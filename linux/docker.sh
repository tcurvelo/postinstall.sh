
function INSTALL_DOCKER {
  # Install packages to allow apt to use a repository over HTTPS:
  APT_UPDATE
  APT_INSTALL \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common

  # Add Docker’s official GPG key:
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  # Set up the stable repository
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  # Install docker ce
  APT_UPDATE
  APT_INSTALL docker-ce
}

