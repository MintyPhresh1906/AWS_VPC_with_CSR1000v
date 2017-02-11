#!/bin/bash
start=$SECONDS
echo 
echo 
echo "WARNING - This script will destroy a VPC. This can not be undone."
echo
echo "These are your current VPCs"
set -x
ls ~/projects/DMVPN/VPCs
set +x
echo -n "Which VPC number would you like to destroy? Please enter a number and  press [ENTER]: "
read VPC
echo
echo
if  [ $VPC -gt 255 ]; then
  echo "You picked a number greater than 255, quitting."
  exit 1
fi

ls ~/projects/DMVPN/VPCs | grep -w "$VPC"

if  [ $? != 0 ]; then
  echo "VPC $VPC does not exist, quitting."
  exit 1
else
  cd ~/projects/DMVPN/VPCs/"$VPC"
fi
echo
echo
ansible-playbook RemoveSmartLicense.yml -vvvv
terraform destroy
cd ~/projects/DMVPN
rm -r ~/projects/DMVPN/VPCs/$VPC
duration=$(( SECONDS - start ))
echo This destruction took $duration seconds.
echo "Have a Nice Day :-)"
