# AWS_VPC_with_CSR1000v
Use Terraform to create VPC with Cisco CSR1000v

Edit terraform.tfvars in the Common Folder to apply your AWS account credentials and CSR1000v key. 

Edit FULLTEMPLATE.j2 and add your DMVPN hub public address

Edit FULLTEMPLATE.yml and DMVPN crypto preshared key

Edit SmartLicenseConfig.yml to add your Cisco Smart License account email address and tokenid

Edit SmartLicenseEnable.yml to change licensing (is now configured for 1Gbps AX feature package)

Copy full projects folder to your home directory as the shell script references ~/projects/DMVPN...

Prepare linux host:

sudo apt-get update

sudo apt-get install software-properties-common

sudo apt-add-repository ppa:ansible/ansible   [enter]

sudo apt-get update

sudo apt-get install ansible   [y]

sudo apt-get install tree

sudo apt-get install unzip

sudo apt-get install python-setuptools python-pip git ack-grep jq  [y]

sudo pip install pyping

sudo pip install PyYAML jinja2 httplib2 six bracket-expansion netaddr


Install Terraform and Ansible on linux

Follow Terraform installation instructions here:

https://www.terraform.io/intro/getting-started/install.html

Remember to add terraform directory PATH

eg., in ~/.profile, add "export PATH=$PATH:/home/vagrant/terraform"


Add Private key

Add openssh version of private key to ~/.ssh

rename to id_rsa

chmod 600 id_rsa

To run program: ~/projects/DMVPN/$ ./createvpc.sh


To unregister CSR1000v from Smart Licensing and delete AWS VPC et all: ~/projects/DMVPN/$ ./destroyvpc.sh
