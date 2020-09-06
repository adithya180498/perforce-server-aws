################################################
#  AWS Terraform For Perforce Server
#  by Simon Stockhause 
################################################

provider "aws" {
  profile = "${var.aws_profile}"
  region = "${var.region}"
}
# Searching And Selecting The  Ubuntu AMI
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

# Pointcloud-tiler Machine
resource "aws_instance" "perforce-server" {
  ami          = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.server_instance_type}"
  key_name = "${var.keypair}"
  tags = {
    Name = "perforce-server"
  } 
  root_block_device {
    volume_type = "standard"
    volume_size = 20
    delete_on_termination = true
  }
  associate_public_ip_address = true
  vpc_security_group_ids = [ "${aws_security_group.perforce_server_SG.id}", "${aws_security_group.ssh.id}","${aws_security_group.http.id}"]
  subnet_id = "${aws_subnet.perforce_server_subnet.id}"
}
