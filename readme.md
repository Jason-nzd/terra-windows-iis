# Terraform - Simple Windows Server on AWS EC2

This Terraform code deploys a simple EC2 Server running Windows Server 2019 with IIS as a web server.

Once deployed it is ready to be used with remote desktop. The server address, username, decrypted password, and a quick RDP command are provided as outputs.

A security group is also created on the default VPC with open ports for `HTTP` and `HTTPS`. `RDP Port 3389` is whitelisted to the auto-detected IP address that applied this script.

## Setup

Requires terraform to be installed and global AWS credentials to be set. A key pair must exist within AWS and the corresponding local .pem file ready for the script to point to.

The default variables can be overwritten in `variables.tf`, or alternatively create a `local.tfvars` and use `terraform apply -var-file="local.tfvars"` with at least:

```terraform
ssh_key_name       = <AWS KeyPair Name (without .pem)>
ssh_key_local_path = <Local Path to key pair .pem file>
``````

Initialize and Plan with:

```terraform
terraform init -upgrade
terraform plan
```

Create infrastructure with without local.tfvars file:

```terraform
terraform apply
terraform apply -varfile local.tfvars
```

Remove infrastructure with:

```terraform
terraform destroy
terraform destroy -varfile local.tfvars
```

## Outputs

Upon applying this terraform, various `terraform output` outputs will be available for access to the server.

Example outputs:

```bash
instance_public_ip     = "3.27.144.217"
rdp_user_name          = "Administrator"
decrypted_rdp_password = "asdf1234"
```

A quick command is created for connecting to RDP (using `mstsc` which is available on local windows systems). The width and height can be changed here, or removed to achieve full screen:

```bash
remote_desktop_command = "mstsc /v:3.27.144.217 /prompt /w:1280 /h:1024"
```
