#!/usr/bin/env bash
set -e

echo "Configuring favorite apps in dock..."

dconf write /org/gnome/shell/favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'code.desktop']"

echo "Dock favorites configured successfully!"
