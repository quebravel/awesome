#!/bin/bash

git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome

sudo pacman -S alsa-utils pasystray

git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install

wget https://raw.githubusercontent.com/rxi/json.lua/refs/heads/master/json.lua -P ~/.config/awesome/
