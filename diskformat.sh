#!/bin/bash
disk=$1
sudo parted /dev/$disk --script mklabel gpt mkpart xfspart xfs 0% 100%
parti="${disk}1"
sudo mkfs.xfs /dev/$parti
sudo partprobe /dev/$parti
