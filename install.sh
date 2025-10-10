#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
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
wget -q https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O vscode.deb
apt install -y ./vscode.deb
rm -f vscode.deb