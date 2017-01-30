#!/bin/bash

#This program creates VPC's

#VPCdir="/home/vagrant/terraform"

echo "Hello.  This script will create VPC directories with files in the terraform directory."

echo -n "Enter the number of your new VPC and press [ENTER]: "
read VPC
echo

ls /home/vagrant/terraform | grep -i "$VPC"

if  [ $? == 0 ]; then
  echo "You already have this VPC directory created, quitting."
  exit 1
else
  mkdir /home/vagrant/terraform/"$VPC"
  cp /home/vagrant/terraform/template/*.* /home/vagrant/terraform/"$VPC"
  echo "Your directory has been created"
  exit 1
fi