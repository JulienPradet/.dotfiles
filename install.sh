#!/bin/bash

sudo echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
rmmod pcspkr

pamac install google-chrome thunderbird code slack-desktop docker docker-compose unbound
pamac build google-chrome
pamac build slack-desktop
pamac build spotify
pamac build gitflow-avh
pamac remove dnsmasq

sudo systemctl start docker
sudo systemctl enable docker
# sudo usermod -aG docker $(whoami)

systemctl disable dnsmasq
systemctl stop dnsmasq
sudo cp ~/.dotfiles/unbound.conf /etc/unbound/unbound.conf

docker network create --subnet=172.10.0.0/16 traefik
docker run -d --restart always --name traefik --net traefik --ip 172.10.0.10 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik --web --docker --docker.domain=test --loglevel=INFO

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s -T ~/.dotfiles/.zshrc ~/.zshrc
source ~/.zshrc

timedatectl set-ntp true 
timedatectl set-timezome Europe/Paris

ln -s -T ~/.dotfiles/.Xresources ~/.Xresources
