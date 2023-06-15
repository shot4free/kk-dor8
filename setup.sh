#!/bin/sh

# 2021-03-18 This uses an out of date key
rm /etc/apt/sources.list.d/yarn.list*

# Working directory for the tutorial
mkdir -p /root/tutorial
cd /root/tutorial

# Clear terminal
printf "\033c"
pwd
