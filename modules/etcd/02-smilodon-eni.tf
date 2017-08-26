## Etcd ENI Interfaces
resource "aws_network_interface" "etcd_eni_az1" {
  count = "${var.asg_maxsize_az1}"

  private_ips = ["${ element(split(",", var.etcd-ips), 0) }"]
 # private_ips       = ["${values(var.etcd_nodes_az1)}"]
  security_groups   = ["${var.etcd-security-group-id}"]
  source_dest_check = false
  #subnet_id         = "${var.subnet_in_az1}"
  #subnet_id         = "${ element(split("," , var.subnet-id-private_etcd),0)}" etcd in other subnet from masr or smilod bi-net
  subnet_id         = "${ element(split("," , var.subnet-id-private),0)}"


  tags {
    Env     = "${var.environment}"
    Name    = "${var.environment}-etcd-data"
    NodeID  = "${count.index}"
#    AZ      = "${var.az1}"
    Role    = "etcd-eni"
    Service = "etcd"
  }
}

## Etcd ENI Interfaces
resource "aws_network_interface" "etcd_eni_az2" {
  count = "${var.asg_maxsize_az2}"

  private_ips = ["${ element(split(",", var.etcd-ips), 1) }"]
  #private_ips       = ["${values(var.etcd_nodes_az2)}"]
  security_groups   = ["${var.etcd-security-group-id}"]
  source_dest_check = false
  #subnet_id         = "${var.subnet_in_az2}"
  #subnet_id         = "${ element(split("," , var.subnet-id-private_etcd),1)}"  bi-net smilod/master
  subnet_id         = "${ element(split("," , var.subnet-id-private),1)}"

  tags {
    Env     = "${var.environment}"
    Name    = "${var.environment}-etcd-data"
    NodeID  = "${count.index + aws_network_interface.etcd_eni_az1.count}"
#    AZ      = "${var.az2}"
    Role    = "etcd-eni"
    Service = "etcd"
  }
}

## Etcd ENI Interfaces
resource "aws_network_interface" "etcd_eni_az3" {
  count = "${var.asg_maxsize_az3}"

  private_ips = ["${ element(split(",", var.etcd-ips), 2) }"]
  #private_ips       = ["${values(var.etcd_nodes_az3)}"]
  security_groups   = ["${var.etcd-security-group-id}"]
  source_dest_check = false
  #subnet_id         = "${var.subnet_in_az3}"
  #subnet_id         = "${ element(split("," , var.subnet-id-private_etcd),2)}"  bi-net smilod or master
  subnet_id         = "${ element(split("," , var.subnet-id-private),2)}"


  tags {
    Env     = "${var.environment}"
    Name    = "${var.environment}-etcd-data"
    NodeID  = "${count.index + aws_network_interface.etcd_eni_az1.count + aws_network_interface.etcd_eni_az2.count}"
#    AZ      = "${var.az3}"
    Role    = "etcd-eni"
    Service = "etcd"
  }
}
