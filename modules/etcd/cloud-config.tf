data "template_file" "cloud-config-az1" {
  #count = "${ length( split(",", var.etcd-ips) ) }"
  template = "${ file( "${ path.module }/cloud-config.yml" )}"

  vars {
    zonename="${var.route53-internal-zone-id}"
    environment = "${var.environment}"
    smilodon_release_url = "${var.smilodon_release_url}"
    smilodon_release_md5 = "${var.smilodon_release_md5}"
    apiserver-count = "${ length( split(",", var.etcd-ips) ) }"
    cluster-domain = "${ var.cluster-domain }"
    cluster-token = "etcd-cluster-${ var.name }"
    dns-service-ip = "${ var.dns-service-ip }"
    external-elb = "${ aws_elb.external.dns_name }"
    fqdn = "etcd1.${ var.internal-tld }"
    hostname = "etcd1"
    hyperkube = "${ var.k8s["hyperkube-image"] }:${ var.k8s["hyperkube-tag"] }"
    hyperkube-image = "${ var.k8s["hyperkube-image"] }"
    hyperkube-tag = "${ var.k8s["hyperkube-tag"] }"
    internal-tld = "${ var.internal-tld }"
    ip-k8s-service = "${ var.ip-k8s-service }"
    s3-bucket = "${ var.s3-bucket }"
    pod-ip-range = "${ var.pod-ip-range }"
    region = "${ var.aws["region"] }"
    service-cluster-ip-range = "${ var.service-cluster-ip-range }"
    etcd-gtwy  = "${element(split(",", var.etcd-gtwy),0)}"
    etcd-ips  = "${element(split(",", var.etcd-ips),0)}"
  }
}

#data "template_cloudinit_config" "config-az1" {
#  gzip          = true
#  base64_encode = false
#
  ##   to overcome  user-data  limit to 16K
  #part {
    #filename     = "init.cfg"
    #content_type = "text/part-handler"
    #content      = "${data.template_file.cloud-config-az1.rendered}"
  #}
#}



data "template_file" "cloud-config-az2" {
  #count = "${ length( split(",", var.etcd-ips) ) }"
  template = "${ file( "${ path.module }/cloud-config.yml" )}"

  vars {
    zonename="${var.route53-internal-zone-id}"
    environment = "${var.environment}"
    smilodon_release_url = "${var.smilodon_release_url}"
    smilodon_release_md5 = "${var.smilodon_release_md5}"
    apiserver-count = "${ length( split(",", var.etcd-ips) ) }"
    cluster-domain = "${ var.cluster-domain }"
    cluster-token = "etcd-cluster-${ var.name }"
    dns-service-ip = "${ var.dns-service-ip }"
    external-elb = "${ aws_elb.external.dns_name }"
    fqdn = "etcd2.${ var.internal-tld }"
    hostname = "etcd2"
    hyperkube = "${ var.k8s["hyperkube-image"] }:${ var.k8s["hyperkube-tag"] }"
    hyperkube-image = "${ var.k8s["hyperkube-image"] }"
    hyperkube-tag = "${ var.k8s["hyperkube-tag"] }"
    internal-tld = "${ var.internal-tld }"
    ip-k8s-service = "${ var.ip-k8s-service }"
    s3-bucket = "${ var.s3-bucket }"
    pod-ip-range = "${ var.pod-ip-range }"
    region = "${ var.aws["region"] }"
    service-cluster-ip-range = "${ var.service-cluster-ip-range }"
    etcd-gtwy  = "${element(split(",", var.etcd-gtwy),1)}"
    etcd-ips  = "${element(split(",", var.etcd-ips),1)}"
  }
}


#data "template_cloudinit_config" "config-az2" {
  #gzip          = true
  #base64_encode = false

  ##   to overcome  user-data  limit to 16K
  ##part {
    ##filename     = "init.cfg"
    #content_type = "text/part-handler"
    #content      = "${data.template_file.cloud-config-az2.rendered}"
  #}
#}



data "template_file" "cloud-config-az3" {
  #count = "${ length( split(",", var.etcd-ips) ) }"
  template = "${ file( "${ path.module }/cloud-config.yml" )}"

  vars {
    zonename="${var.route53-internal-zone-id}"
    environment = "${var.environment}"
    smilodon_release_url = "${var.smilodon_release_url}"
    smilodon_release_md5 = "${var.smilodon_release_md5}"
    apiserver-count = "${ length( split(",", var.etcd-ips) ) }"
    cluster-domain = "${ var.cluster-domain }"
    cluster-token = "etcd-cluster-${ var.name }"
    dns-service-ip = "${ var.dns-service-ip }"
    external-elb = "${ aws_elb.external.dns_name }"
    fqdn = "etcd3.${ var.internal-tld }"
    hostname = "etcd3"
    hyperkube = "${ var.k8s["hyperkube-image"] }:${ var.k8s["hyperkube-tag"] }"
    hyperkube-image = "${ var.k8s["hyperkube-image"] }"
    hyperkube-tag = "${ var.k8s["hyperkube-tag"] }"
    internal-tld = "${ var.internal-tld }"
    ip-k8s-service = "${ var.ip-k8s-service }"
    s3-bucket = "${ var.s3-bucket }"
    pod-ip-range = "${ var.pod-ip-range }"
    region = "${ var.aws["region"] }"
    service-cluster-ip-range = "${ var.service-cluster-ip-range }"
    etcd-gtwy  = "${element(split(",", var.etcd-gtwy),2)}"
    etcd-ips  = "${element(split(",", var.etcd-ips),2)}"
  }
}


#data "template_cloudinit_config" "config-az3" {
  #gzip          = true
  #base64_encode = false
#
  ##   to overcome  user-data  limit to 16K
  #part {
    #filename     = "init.cfg"
    #content_type = "text/part-handler"
    #content      = "${data.template_file.cloud-config-az3.rendered}"
  #}
#}
#

