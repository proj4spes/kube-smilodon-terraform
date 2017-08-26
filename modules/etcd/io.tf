
variable "azs"{  } 
variable "route53-internal-zone-id" {} 

### ASG configuration for each AZ

variable "asg_name_az1" {
   description = "name of asg master and etcd "
   default    = "asg-etcd1"
}

variable "asg_maxsize_az1" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_minsize_az1" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_normsize_az1" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_name_az2" {
   description = "name of asg master and etcd "
   default    = "asg-etcd2"
}

variable "asg_maxsize_az2" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_minsize_az2" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_normsize_az2" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_name_az3" {
   description = "name of asg master and etcd "
   default    = "asg-etcd3"
}

variable "asg_maxsize_az3" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "asg_minsize_az3" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}
         
variable "asg_normsize_az3" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 600
}

variable "health_check_type" {
  default = "ELB"
}


 

variable "lc_name" { 
  default = "etcd_lc"
}

variable "environment" { 
  default = "Staging"
}

## EBS volumes

variable "ebs_encrypted" { 
  default = "True"
}

variable "ebs_size" {  
  default = "20"
}

variable "ebs_type" { 
  default = "standard"
}

# smilodon

variable "smilodon_release_url" {
  description = "The release URL for the smilodon binary"
  default     = "https://github.com/UKHomeOffice/smilodon/releases/download/v0.1.0/smilodon-0.1.0-linux-amd64"
}

variable "smilodon_release_md5" {
  description = "The release MD5 for the smilodon binary"
  default     = "500aa5f37a332d8e680c7d707b524077"
}

#----------------
variable "ami-id" {}
variable "aws" {
  type = "map"
}
variable "cluster-domain" {}
variable "depends-id" {}
variable "dns-service-ip" {}
variable "etcd-ips" {}
variable "etcd-gtwy" {}
variable "etcd-security-group-id" {}
variable "external-elb-security-group-id" {}
variable "instance-profile-name" {}
variable "instance-type" {}
variable "internal-tld" {}

variable "ip-k8s-service" {}

variable "k8s" {
  type = "map"
}

variable "name" {}
variable "s3-bucket" {}
variable "pod-ip-range" {}
variable "service-cluster-ip-range" {}
variable "subnet-id-private" {}
variable "subnet-id-private_etcd" {}
variable "subnet-id-public" {}
variable "vpc-id" {}

output "depends-id" { value = "${ null_resource.dummy_dependency.id }" }
output "external-elb" { value = "${ aws_elb.external.dns_name }" }
#output "internal-ips" { value = "${ join(",", aws_instance.etcd.*.public_ip) }" }
