
function INSTALL_NODE  {
    curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

function NPM_INSTALL {
    $SUDO npm install -g npm $(echo $*)
}
