
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
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install docker ce
  APT_UPDATE
  APT_INSTALL docker-ce
}

