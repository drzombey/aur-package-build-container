#!/usr/bin/env bash

set -e

if [ ! -f /build/PKGBUILD ]; then
  echo -e "The folder /build must countain the PKGBUILD file."
  exit 1
fi

cd /build
chown -R makepkg:users /build

pacman -Syy --noconfirm
pacman-key --init
pacman -S archlinux-keyring --noconfirm

sudo -u makepkg makepkg --noconfirm -sf
sudo -u makepkg makepkg --printsrcinfo > .SRCINFO

mv /home/makepkg/out/* /pkg