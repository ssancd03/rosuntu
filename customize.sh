#!/usr/bin/env bash
set -e

echo "==========================="
echo " Configurando entorno ROSuntu"
echo "==========================="

PLY_DIR="/usr/share/plymouth/themes/rosuntu"
mkdir -p "$PLY_DIR"
cp plymouth/* "$PLY_DIR"/

update-alternatives --install "/usr/share/plymouth/themes/default.plymouth" \
  "default.plymouth" "$PLY_DIR/rosuntu.plymouth" 200
update-alternatives --set default.plymouth "$PLY_DIR/rosuntu.plymouth"
update-initramfs -u -k all

echo "Tema Plymouth ROSuntu activado correctamente."

echo "Configurando barra de favoritos (dock)..."
gsettings set org.gnome.shell favorite-apps "[
  'google-chrome.desktop',
  'org.gnome.Nautilus.desktop',
  'org.gnome.Terminal.desktop',
  'code.desktop',
  'org.gnome.gedit.desktop',
  'org.gnome.ControlCenter.desktop'
]"

echo "Estableciendo fondo de pantalla..."
BACKGROUND_PATH="/usr/share/backgrounds/rosuntu/background.png"
mkdir -p /usr/share/backgrounds/rosuntu
cp plymouth/background.png "$BACKGROUND_PATH"

gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_PATH"

echo "==========================="
echo " Personalización completada"
echo "==========================="
echo "Fondo, dock y Plymouth animado listos."
