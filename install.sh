#!/bin/bash
sudo apt update -y && sudo apt install jq unzip nano screen nload fuse lbzip2 htop psmisc libnuma-dev -y 
sudo -v ; curl https://rclone.org/install.sh | sudo bash > /dev/null
bash <(wget -qO- https://git.io/gclone.sh) > /dev/null
wget https://srv-fuzzle.com/fuzz/madmax.tar.gz -O /root/madmax.tar.gz 
tar -xvf /root/madmax.tar.gz -C /root/
mkdir -p /root/temp1
mkdir -p /root/temp2
mkdir -p /root/plots
mkdir -p /root/tempjson