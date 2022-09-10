#!/bin/bash

# More safety, by turning some bugs into errors.
set -euCo pipefail
IFS=$'\n\t'

set -x

cp -r .config .fonts.conf.d ~/

mkdir -p ~/.fonts

cd ~/.fonts

rm NerdFontsSymbolsOnly.zip || true
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip

unzip -o NerdFontsSymbolsOnly.zip
rm NerdFontsSymbolsOnly.zip

fc-cache -fv
