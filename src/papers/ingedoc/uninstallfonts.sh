#!/bin/bash
# Written by Stephane Galland <stephane.galland@utbm.fr>
CURRENTDIR=`dirname "$0"`
rm -rf "$HOME/.texmf-var/fonts/afm/lucas"
rm -rf "$HOME/.texmf-var/fonts/map/lucas"
rm -rf "$HOME/.texmf-var/fonts/tfm/lucas"
rm -rf "$HOME/.texmf-var/fonts/type1/lucas"
rm -rf "$HOME/.texmf-var/fonts/vf/lucas"
rm -rf "$HOME/.texmf-var/tex/latex/lucas"
rm -f "$HOME/.texmf-config/updmap.d/fz0.cfg"
rm -f "$HOME/.texmf-config/updmap.d/fz1.cfg"
rm -f "$HOME/.texmf-config/updmap.d/fz2.cfg"
rm -f "$HOME/.texmf-config/updmap.d/fz3.cfg"
rm -f "$HOME/.texmf-config/updmap.d/fz4.cfg"
rm -rf "$HOME/.texmf-var/web2c"
rm -rf "$HOME/.texmf-var/fonts/map/dvipdfm"
rm -rf "$HOME/.texmf-var/fonts/map/dvips"
rm -rf "$HOME/.texmf-var/fonts/map/pdftex"
find "$HOME/.texmf-config" -depth -type d -empty -exec rmdir {} \;
find "$HOME/.texmf-var" -depth -type d -empty -exec rmdir {} \;
mktexlsr
update-updmap
updmap
echo "The font files were removed from $HOME/.texmf-var and $HOME/.texmf-config"
