#!/bin/bash

#TODO: pedir pelo login e senha
#$LOGIN=
#$SENHA=

PROXY_URL=http://$LOGIN:$SENHA@10.13.10.250:8080/

#Configura proxy para apt e http
sudo cat << EOF >> /etc/apt/apt.conf 
Acquire{
	ftp::"$PROXY_URL";
	http::"$PROXY_URL";
	https::"$PROXY_URL";
}
EOF

sudo cat << EOF >> /etc/profile
export ftp_proxy="$PROXY_URL";
export http_proxy="$PROXY_URL";
export https_proxy="$PROXY_URL";
}
EOF

sudo apt-get -y update

#Apaga alguns pacotes não-essenciais para desenvolvimento
sudo apt-get -y remove rhythmbox brasero totem libreoffice-core thunderbird bluez

#Configura as unidades de rede
#sudo apt-get install smbfs

#Instala o suporte a pt_BR
#TODO

#Instala pacotes adicionais do VirtualBox
sudo apt-get install virtualbox-guest-additions virtualbox-guest-x11


###############################
# Ambiente de desenvolvimento #
###############################
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get -y install build-essential curl git guake mercurial sublime-text-2 subversion unixodbc-dev vim zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

#configura proxy para subversion
#TODO

#TODO: instalar o 2.6 e 2.4#
#criar ~/bin/ com e com virtualenv2.6

