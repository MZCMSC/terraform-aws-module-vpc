# terraform-aws-module-vpc

- Create by terraform module VPC
- Terraform 을 사용하여 AWS VPC 생성
  - 생성 항목
    - VPC/Subnet/Route_table/IGW/NATGW/EIP/SG(Default-SG)

## Usage

#### `main.tf`

```hcl
module "vpc" {
  source = "git::https://github.com/MZCMSC/terraform-aws-module-vpc.git"

  region = var.region

  prefix = var.prefix

  azs = var.azs

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_internet_gateway = var.enable_internet_gateway
  enable_nat_gateway      = var.enable_nat_gateway

  subnets = var.subnets

  tags = var.tags
}

```

#### `terraform.tfvars`

```hcl
region = "ap-northeast-2"

prefix = "test"

azs = ["ap-northeast-2a", "ap-northeast-2c"]

vpc_name = "tf-vpc"
vpc_cidr = "10.50.0.0/16"

enable_dns_hostnames = "true"
enable_dns_support   = "true"

enable_internet_gateway = "true"
enable_nat_gateway      = "true"

subnets = {
  main = {
    "cidr"  = ["10.50.10.0/24", "10.50.20.0/24"]
    "type"  = "public"
    "natgw" = "no"
  },
  web = {
    "cidr"  = ["10.50.110.0/24", "10.50.120.0/24"]
    "type"  = "private"
    "natgw" = "no"
  },
  was = {
    "cidr"  = ["10.50.130.0/24", "10.50.140.0/24"]
    "type"  = "private"
    "natgw" = "yes"
  },
  rds = {
    "cidr"  = ["10.50.210.0/24", "10.50.220.0/24"]
    "type"  = "private"
    "natgw" = "no"
  }
}

tags = {
  "CreatedByTerraform" = "True"
  "purpose"            = "Terraform_Test"
  "owner"              = "MSC"
  "resource"           = "VPC"
}
```

#### `variable.tf`

```hcl
variable "region" {
  type        = string
  default     = ""
}
variable "prefix" {
  type        = string
  default     = ""
}
variable "azs" {
  type        = list(string)
  default     = []
}
variable "vpc_name" {
  type        = string
  default     = ""
}
variable "vpc_cidr" {
  type        = string
  default     = ""
}
variable "enable_dns_hostnames" {
  type    = string
  default = "true"
}
variable "enable_dns_support" {
  type    = string
  default = "true"
}

variable "enable_internet_gateway" {
  type        = string
  default     = "false"
}

variable "enable_nat_gateway" {
  type        = string
  default     = "false"
}

variable "subnets" {
  type        = map(any)
  default = { }
}

variable "tags" {
  type        = map(string)
  default = { }
}
```

#### `terraform.tf`

```hcl
terraform {
  required_version = ">= 1.2.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}
```

#### `provider.tf`

```hcl
provider "aws" {
  region = var.region
}
```
