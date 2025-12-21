# Terraform for DevOps

This repository is a **one-stop solution for Terraform** tailored specifically for **DevOps Engineers**.  
It provides a comprehensive, practical guide to Terraform commands, workflows, and best practices commonly used in real-world infrastructure automation.

---

## Terraform Commands – Complete Guide

---

## 1. Setup & Initialization

### Install Terraform

#### Linux & macOS
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
Verify Installation
bash
Copy code
terraform -v
Initialize Terraform
bash
Copy code
terraform init
What this does:

Downloads required provider plugins

Initializes the working directory

Configures backend (if defined)

2. Terraform Core Commands
Format & Validate Code
bash
Copy code
terraform fmt        # Formats Terraform code
terraform validate   # Validates Terraform configuration
Plan & Apply Infrastructure
bash
Copy code
terraform plan       # Shows execution plan
terraform apply      # Applies changes
terraform apply -auto-approve  # Skips manual approval
Destroy Infrastructure
bash
Copy code
terraform destroy
terraform destroy -auto-approve
3. Managing Terraform State
Inspect Current State
bash
Copy code
terraform state list
terraform show
Manually Modify State
bash
Copy code
terraform state mv <source> <destination>
terraform state rm <resource>
Note: These commands modify the state file only and do not directly affect infrastructure.

Remote Backend (S3 & DynamoDB)
hcl
Copy code
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
bash
Copy code
terraform init
4. Variables & Outputs
Define Variables
hcl
Copy code
variable "instance_type" {
  default = "t2.micro"
}
Use Variables
hcl
Copy code
resource "aws_instance" "web" {
  instance_type = var.instance_type
}
Pass Variables via CLI
bash
Copy code
terraform apply -var="instance_type=t3.small"
Output Values
hcl
Copy code
output "instance_ip" {
  value = aws_instance.web.public_ip
}
bash
Copy code
terraform output instance_ip
5. Loops & Conditionals
for_each Example
hcl
Copy code
resource "aws_s3_bucket" "example" {
  for_each = toset(["bucket1", "bucket2", "bucket3"])
  bucket   = each.key
}
Conditional Expressions
hcl
Copy code
variable "env" {}

resource "aws_instance" "example" {
  instance_type = var.env == "prod" ? "t3.large" : "t2.micro"
}
6. Terraform Modules
Create a Module
bash
Copy code
mkdir -p modules/vpc
modules/vpc/main.tf

h
Copy code
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
Use the Module (Root Module)
hcl
Copy code
module "vpc" {
  source = "./modules/vpc"
}
bash
Copy code
terraform init
terraform apply
7. Workspaces (Environment Management)
bash
Copy code
terraform workspace new dev
terraform workspace new prod
terraform workspace select prod
terraform workspace list
Use Case:
Manage multiple environments (dev, staging, prod) using the same codebase.

8. Terraform Debugging & Logs
Enable Debug Logging
bash
Copy code
export TF_LOG=DEBUG
Save Logs to File
bash
Copy code
terraform apply 2>&1 | tee debug.log
Projects
Terraform with Ansible
Get it here

Terraform with GitHub Actions
Get it here

Terraform to EKS
Get it here

Final Thoughts
This repository covers all essential Terraform commands and concepts required for “Terraform in One Shot” learning and real-world DevOps implementation.

For enhancements, advanced examples, or integrations, feel free to extend this repository.

markdown
Copy code

If you want, I can also:
- Add **AWS IAM + EC2 examples**
- Include **CI/CD with GitHub Actions**
- Add **Terraform best practices & folder structure**
- Convert this into **Docs + Diagrams** format

Just tell me.
