#!/usr/bin/env bash
set -e

echo "Configuring favorite apps in dock..."

mkdir -p /etc/dconf/db/local.d
cat > /etc/dconf/db/local.d/01-favorite-apps << 'EOF'
[org/gnome/shell]
favorite-apps=['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'code.desktop']
EOF

dconf update

echo "Dock favorites configured successfully!"
