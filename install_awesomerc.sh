#!/bin/bash

if [[ -d ~/.config/awesome ]]; then
  echo "Pasta awesome já existe!!!"
  read -rp "Quer apagar a pasta e baixar novamente a cofiguração? (s,n)? " baixar_or_not
  case "$baixar_or_not" in
    s | S)
      rm -rf ~/.config/awesome/
      git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome
    ;;

    n | N) exit 1
    ;;
  esac

else
  git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome
fi

sudo pacman -Sy --noconfirm --needed alsa-utils pasystray python-gobject picom gammastep network-manager-applet

sudo systemctl disable iwd.service
sudo systemctl disable systemd-resolved.service
sudo systemctl disable systemd-networkd.service

sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

(git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc-icon-theme && cd ~/arc-icon-theme && ./autogen.sh --prefix=/usr sudo make install && rm -rf ~/arc-icon-theme)

wget https://raw.githubusercontent.com/rxi/json.lua/refs/heads/master/json.lua -P ~/.config/awesome/

echo 'awesome.restart()' | awesome-client
