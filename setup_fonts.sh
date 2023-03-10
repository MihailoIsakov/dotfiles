#! /bin/sh

# exit if any command fails
set -e

#
# Install powerline-shell fonts
#
cd /tmp

# Download the latest version of the symbol font and fontconfig file:
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Download Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip
# manually install nerd fonts, then run 
#   `fc-cache -r`
# check that kitty is picking up the fonts using
#   `kitty --debug-font-fallback`
# check available fonts using:
#   `kitty +list-fonts`

# Move the symbol font to a valid X font path. 
# Valid font paths can be listed with xset q: 
mkdir -p ~/.local/share/fonts/
mv PowerlineSymbols.otf ~/.local/share/fonts/ 

# Update font cache for the path the font was moved to 
# (root priveleges may be needed to update cache for the 
# system-wide paths):
fc-cache -vf ~/.local/share/fonts/

# Install the fontconfig file. 
# For newer versions of fontconfig the config path is 
# ~/.config/fontconfig/conf.d/, 
# for older versions it’s ~/.fonts.conf.d/:
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/


