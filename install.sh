#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}   Update and Upgrade   ${RESET}"
echo -e "${GREEN}========================${RESET}"
apt update && apt upgrade -y

read -p "Press Enter to continue..."
clear

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}   Installing ROS 2 Jazzy     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y software-properties-common curl gnupg lsb-release
add-apt-repository universe -y

curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list
apt update
apt install -y ros-jazzy-desktop ros-dev-tools ros-jazzy-ros-gz

read -p "Press Enter to continue..."
clear

echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN}  Installing VSCode     ${RESET}"
echo -e "${CYAN}========================${RESET}"
apt install -y wget
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
apt install -y ./vscode.deb
rm -f vscode.deb

read -p "Press Enter to continue..."
clear

echo -e "${YELLOW}================================${RESET}"
echo -e "${YELLOW} Installing GNOME Tools and Git ${RESET}"
echo -e "${YELLOW}================================${RESET}"
apt install -y gnome-control-center git

read -p "Press Enter to continue..."
clear

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Installing Chrome     ${RESET}"
echo -e "${GREEN}========================${RESET}"
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

read -p "Press Enter to continue..."
clear

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Installing Docker     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce
groupmod -g 1000 docker

read -p "Press Enter to continue..."
clear

echo -e "${YELLOW}========================${RESET}"
echo -e "${YELLOW} Configuring Defaults   ${RESET}"
echo -e "${YELLOW}========================${RESET}"
cp conf/90_ubuntu-settings.gschema.override /usr/share/glib-2.0/schemas/
glib-compile-schemas /usr/share/glib-2.0/schemas

read -p "Press Enter to continue..."
clear

echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN} Configuring .bashrc    ${RESET}"
echo -e "${CYAN}========================${RESET}"
echo "source /opt/ros/jazzy/setup.bash" >> /etc/skel/.bashrc

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN} Install complete!      ${RESET}"
echo -e "${GREEN}========================${RESET}"