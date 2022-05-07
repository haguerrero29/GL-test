#!/bin/sh

sudo apt-get update
sudo apt-get install -y default-jdk

# Install Node.js 6.x repository
curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install Node.js and npm
sudo apt-get install -y nodejs

# Install sqlite
sudo apt install sqlite3