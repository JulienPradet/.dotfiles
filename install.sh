#!/bin/bash

sudo echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
rmmod pcspkr

pamac update
pamac install thunderbird code docker docker-compose unbound ansible tk
pamac build google-chrome slack-desktop spotify gitflow-avh
pamac remove dnsmasq

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $(whoami)

sudo systemctl disable dnsmasq
sudo systemctl stop dnsmasq
sudo cp ~/.dotfiles/unbound.conf /etc/unbound/unbound.conf
sudo systemctl enable unbound
sudo systemctl start unbound
# Configure network Ipv4settings => Automatic (DHCP) addresses only

docker network create --subnet=172.10.0.0/16 traefik
docker run -d --restart always --name traefik --net traefik --ip 172.10.0.10 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik --web --docker --docker.domain=test --loglevel=INFO

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/.dotfiles/.zshrc ~/.zshrc
source ~/.zshrc

timedatectl set-ntp true 
timedatectl set-timezome Europe/Paris

cp ~/.dotfiles/.Xresources ~/.Xresources
xrdb ~/.Xresources

cp ~/.dotfiles/i3config ~/.i3/config
