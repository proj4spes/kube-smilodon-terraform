resource "aws_launch_configuration" "launch_config-az1" {
  name_prefix          = "${var.lc_name}"
  image_id             = "${var.ami-id}"
  instance_type        = "${var.instance-type}"
  iam_instance_profile = "${var.instance-profile-name}"
  key_name             = "${var.aws["key-name"]}"
  security_groups      = ["${var.etcd-security-group-id}"]
  user_data            = "${data.template_file.cloud-config-az1.rendered}"


 root_block_device {
    volume_size = 64
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "launch_config-az2" {
  name_prefix          = "${var.lc_name}"
  image_id             = "${var.ami-id}"
  instance_type        = "${var.instance-type}"
  iam_instance_profile = "${var.instance-profile-name}"
  key_name             = "${var.aws["key-name"]}"
  security_groups      = ["${var.etcd-security-group-id}"]
 # user_data            = "${data.template_file.cloud-config-az2.rendered}"
  user_data            = "${data.template_file.cloud-config-az2.rendered}"

 root_block_device {
    volume_size = 64
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "launch_config-az3" {
  name_prefix          = "${var.lc_name}"
  image_id             = "${var.ami-id}"
  instance_type        = "${var.instance-type}"
  iam_instance_profile = "${var.instance-profile-name}"
  key_name             = "${var.aws["key-name"]}"
  security_groups      = ["${var.etcd-security-group-id}"]
   user_data            = "${data.template_file.cloud-config-az3.rendered}"
  #user_data            = "${data.template_cloudinit_config.config-az3.rendered}"


 root_block_device {
    volume_size = 64
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}
