#!/bin/bash
echo 
echo 
echo "Hello.  This script will create a VPC with public and private route tables utilizing a Cisco CSR1000v router with DMVPN and a Front Door VRF in AWS."
echo
echo
echo -n "Please enter a number between 0 and 255 for your new VPC and press [ENTER]: "
read VPC
echo
echo
if  [ $VPC -gt 255 ]; then
  echo "You picked a number greater than 255, quitting."
  exit 1
fi

ls ~/projects/DMVPN/VPCs | grep -i "$VPC"

if  [ $? == 0 ]; then
  echo "VPC $VPC has already been created, quitting."
  exit 1
else
  mkdir ~/projects/DMVPN/VPCs/"$VPC"
  cp -a ~/projects/DMVPN/Common/. ~/projects/DMVPN/VPCs/"$VPC"
  echo "The VPC $VPC directory has been created and populated with the common files."
fi

echo "Time to update the terraform variables.tf file with the VPC $VPC information"
mkdir ~/projects/DMVPN/tmp$VPC
python replace.py $VPC
echo 
echo
echo "Time to render the configuration template with the variables"

cp TEMPLATES/FULLTEMPLATE.j2 tmp$VPC
cp Scripts/render.py tmp$VPC
python tmp$VPC/render.py tmp$VPC/FULLTEMPLATE > VPCs/$VPC/FULLTEMPLATE.yml

cd ~/projects/DMVPN/VPCs/$VPC
echo "Clean the anisble template"
echo 
echo
python clean.py
rm FULLTEMPLATE.yml

echo "Time to deploy VPC, subnets, RTs, EIP, SGs, and Cisco CSR1000v in AWS"
echo
echo
terraform plan
terraform apply
cat terraform.tfstate | grep "public_ip" > dictionary
IP=$(python searchIP.py)
echo "The CSR1000v's EIP is $IP"
echo
echo 
echo "Now we wait for the CSR1000v to initialize"
python edithosts.py $IP
sudo python CSRReachability.py $IP
echo "Time to program the router"
echo
echo
ansible-playbook CLEANTEMPLATE.yml -vvvv
ansible-playbook commandEEM.yml -vvvv
python attachENI.py
rm vpc.tf
echo "Now we add the CSR1000v G2 interface"
echo
echo 
terraform refresh
terraform plan
terraform apply
cd ~/projects/DMVPN
cp TEMPLATES/G2INTERFACE.j2 tmp$VPC
cp tmp$VPC/FULLTEMPLATE.yml tmp$VPC/G2INTERFACE.yml
python tmp$VPC/render.py tmp$VPC/G2INTERFACE > VPCs/$VPC/G2INTERFACE.yml
cd ~/projects/DMVPN/VPCs/$VPC
python cleanG2.py
rm G2INTERFACE.yml
ansible-playbook CLEANG2INTERFACE.yml -vvvv
cd ~/projects/DMVPN
rm -r tmp$VPC
echo "Have a Nice Day :-)"
