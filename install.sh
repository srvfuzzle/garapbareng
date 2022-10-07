#!/bin/bash
apt update -y && apt install sudo jq unzip progress htop nano screen nload fuse lbzip2 htop psmisc wget curl libnuma-dev -y
curl https://rclone.org/install.sh | bash > /dev/null
#bash <(wget -qO- https://git.io/gclone.sh) > /dev/null
wget https://srv-fuzzle.com/fuzz/madmax.tar.gz -O /root/madmax.tar.gz
wget https://github.com/kahing/goofys/releases/download/v0.24.0/goofys -O /usr/local/bin/goofys
chmod +x /usr/local/bin/goofys
tar -xvf /root/madmax.tar.gz -C /root/
sudo wget https://github.com/Chia-Network/bladebit/releases/download/v1.2.4/bladebit-v1.2.4-ubuntu-x86-64.tar.gz -O /root/bladebit-v1.2.4-ubuntu-x86-64.tar.gz && tar -xvf /root/bladebit-v1.2.4-ubuntu-x86-64.tar.gz -C /root/
mkdir -p /root/temp1
mkdir -p /root/temp2
mkdir -p /root/plots
mkdir -p /root/tempjson