#!/bin/bash

git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome

sudo pacman -S alsa-utils pasystray python-gobject picom gammastep network-manager-applet

sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

(git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc-icon-theme && cd ~/arc-icon-theme && ./autogen.sh --prefix=/usr sudo make install && rm -rf ~/arc-icon-theme)

wget https://raw.githubusercontent.com/rxi/json.lua/refs/heads/master/json.lua -P ~/.config/awesome/

