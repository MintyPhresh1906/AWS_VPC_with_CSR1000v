#!/bin/bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
sudo apt-get install tree
sudo apt-get install unzip
sudo apt-get install python-setuptools python-pip git ack-grep jq
sudo pip install pyping
sudo pip install PyYAML jinja2 httplib2 six bracket-expansion netaddr