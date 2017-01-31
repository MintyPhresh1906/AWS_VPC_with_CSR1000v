# AWS_VPC_with_CSR1000v
Use Terraform to create VPC with Cisco CSR1000v

Edit the variables.tf file to assign CIDR block, public subnet, private subnet, and private interface IP address.

Edit terraform.tfvars to apply your AWS account credentials and CSR1000v key. 


NOTE - Post configuration of FVRF on CSR1000v, in vpc.tf, uncomment all commented lines (AWS private route table and aws interface G2 configurations), save vpc.tf, and run "terraform refresh" and "terraform apply".  
