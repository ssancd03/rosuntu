#!/usr/bin/env bash

# Copyright (C) 2024  Miguel Ángel González Santamarta
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# Define color codes
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Update + Upgrade
echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}   Update and Upgrade   ${RESET}"
echo -e "${GREEN}========================${RESET}"
apt update && apt upgrade -y

# ROS 2 Jazzy
echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}   Installing ROS 2     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y software-properties-common
add-apt-repository universe -y
apt update && apt install -y curl gnupg lsb-release

# Add ROS Jazzy repository
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
apt update

# Install ROS 2 packages + Gazebo
apt install -y ros-jazzy-desktop ros-dev-tools ros-jazzy-ros-gz

# Install GNOME tools and Git
echo -e "${YELLOW}================================${RESET}"
echo -e "${YELLOW} Installing GNOME Tools and Git ${RESET}"
echo -e "${YELLOW}================================${RESET}"
apt install -y gnome-control-center git

# Install VSCode
echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN}  Installing VSCode     ${RESET}"
echo -e "${CYAN}========================${RESET}"
apt install -y apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
apt update
apt install -y code

# Install Google Chrome
echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Installing Chrome     ${RESET}"
echo -e "${GREEN}========================${RESET}"
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb || apt install -fy

# Install Docker
echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Installing Docker     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y ca-certificates curl
install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce
groupmod -g 1000 docker

# Plymouth
echo -e "${YELLOW}========================${RESET}"
echo -e "${YELLOW}  Preparing Plymouth    ${RESET}"
echo -e "${YELLOW}========================${RESET}"
mkdir -p /usr/share/plymouth/themes/rosuntu
cp plymouth/*.png /usr/share/plymouth/themes/rosuntu/
cp plymouth/rosuntu.script /usr/share/plymouth/themes/rosuntu/
cp plymouth/rosuntu.plymouth /usr/share/plymouth/themes/rosuntu/
update-alternatives --install "/usr/share/plymouth/themes/default.plymouth" "default.plymouth" "/usr/share/plymouth/themes/rosuntu/rosuntu.plymouth" 160
update-initramfs -uk all

# Login screen logos
echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN}   Setting Login Screen ${RESET}"
echo -e "${CYAN}========================${RESET}"
cp logo/*.png /usr/share/plymouth/

# Wallpapers
echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Preparing Wallpapers  ${RESET}"
echo -e "${GREEN}========================${RESET}"
mkdir -p /usr/share/backgrounds/rosuntu
cp wallpaper/*.png /usr/share/backgrounds/rosuntu/
cp wallpaper/rosuntu-wallpapers.xml /usr/share/gnome-background-properties/

# Ubiquity slides
echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Preparing Ubiquity    ${RESET}"
echo -e "${BLUE}========================${RESET}"
mkdir -p /usr/share/ubiquity-slideshow/slides
mkdir -p /usr/share/ubiquity-slideshow/pixmaps
cp -r ubiquity/slides/* /usr/share/ubiquity-slideshow/slides/
cp -r ubiquity/pixmaps/* /usr/share/ubiquity-slideshow/pixmaps/

# Configure defaults
echo -e "${YELLOW}========================${RESET}"
echo -e "${YELLOW} Configuring Defaults   ${RESET}"
echo -e "${YELLOW}========================${RESET}"
cp conf/90_ubuntu-settings.gschema.override /usr/share/glib-2.0/schemas/
glib-compile-schemas /usr/share/glib-2.0/schemas

# Configure .bashrc
echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN} Configuring .bashrc    ${RESET}"
echo -e "${CYAN}========================${RESET}"
echo "source /opt/ros/jazzy/setup.bash" >> /etc/skel/.bashrc

# Show kernel
echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}    Showing Kernel      ${RESET}"
echo -e "${GREEN}========================${RESET}"
ls -la /boot
