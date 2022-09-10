#!/bin/bash

sudo apt-get -y install kitty

mkdir -p ~/.config/kitty
cp kitty.conf neighboring_window.py pass_keys.py ~/.config/kitty/

