#!/bin/bash

# This should work on Ubuntu Trusty.
# Prefered launch mechanism is without sudo already invoked.  
# Script will request sudo as necessary. 
set -e

sudo apt-get install git -y
git clone https://github.com/therootcause/seabass.git

cd seabass/

# download cookbook dependencies
sudo apt-get update 
sudo apt-get install -y bundler
bundle
berks vendor ~/cookbooks

# install chef-solo
curl https://opscode.com/chef/install.sh | sudo bash -

# tell chef to use that cookbook path
sudo mkdir /etc/chef
echo "cookbook_path [ '$HOME/cookbooks/']" | sudo tee /etc/chef/solo.rb
sudo chef-solo -o dbassbuild::jenkins-server

echo "done!"
