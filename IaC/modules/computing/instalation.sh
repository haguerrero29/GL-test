#!/bin/bash

sudo apt-get update
sudo apt-get install -y default-jdk

curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -

# Install Node.js and npm
sudo apt-get install -y nodejs

# Install NPM
sudo apt install -y npm

#Install python
sudo apt install -y build-essential python3

sudo ln -s /usr/bin/python3 /usr/bin/python

# Install sqlite
sudo apt install -y sqlite3

sudo apt install -y git