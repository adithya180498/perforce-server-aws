################################################
#  AWS Terraform For Perforce Server    
#  by Simon Stockhause 
################################################

# Create A File Which Contains The Created Hosts From AWS
# Contains:
# - 
data  "template_file" "aws" {
    template = "${file("./templates/hosts.tpl")}"
    vars = {
        ansible_ssh_private_key_file= "${var.ssh_private_key_file_path}"
        perforce-server = aws_instance.perforce-server.public_dns
    }
}

resource "local_file" "aws_file" {
  content  = "${data.template_file.aws.rendered}"
  filename = "./ansible-provisioning/aws-hosts"
}
