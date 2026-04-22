#!/bin/bash
# Written by Stephane Galland <stephane.galland@utbm.fr>
CURRENTDIR=`dirname "$0"`
mkdir -p "$HOME/.texmf-var/fonts/afm/lucas/thesans"
mkdir -p "$HOME/.texmf-var/fonts/map/lucas/thesans"
mkdir -p "$HOME/.texmf-var/fonts/tfm/lucas/thesans"
mkdir -p "$HOME/.texmf-var/fonts/type1/lucas/thesans"
mkdir -p "$HOME/.texmf-var/fonts/vf/lucas/thesans"
mkdir -p "$HOME/.texmf-var/tex/latex/lucas/thesans"
mkdir -p "$HOME/.texmf-config/updmap.d/"
cp -f "$CURRENTDIR/fonts/"*.afm "$HOME/.texmf-var/fonts/afm/lucas/thesans"
cp -f "$CURRENTDIR/fonts/"*.map "$HOME/.texmf-var/fonts/map/lucas/thesans"
cp -f "$CURRENTDIR/fonts/"*.cfg "$HOME/.texmf-config/updmap.d"
cp -f "$CURRENTDIR/fonts/"*.tfm "$HOME/.texmf-var/fonts/tfm/lucas/thesans"
cp -f "$CURRENTDIR/fonts/"*.pfb "$HOME/.texmf-var/fonts/type1/lucas/thesans"
cp -f "$CURRENTDIR/fonts/"*.vf "$HOME/.texmf-var/fonts/vf/lucas/thesans"
cp -f "$CURRENTDIR/fonts/"*.fd "$HOME/.texmf-var/tex/latex/lucas/thesans"
mktexlsr
update-updmap
updmap
echo "The font files were installed in $HOME/.texmf-var and $HOME/.texmf-config"
