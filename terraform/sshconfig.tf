################################################
#  AWS SSH Config File creattion via template        
#  by Simon Stockhause 
################################################

# Create A File Which Contains The Necessary SSH Configurations
# To Access AWS Machines From A Remote Machine
data  "template_file" "ssh" {
    template = "${file("./templates/ssh_config.tpl")}"
    vars = {
        bastion_node = aws_instance.perforce-server.public_dns
        ssh_key = "${var.ssh_private_key_file_path}"
        ssh_username = "ubuntu"
    }
}

resource "local_file" "ssh_file" {
  content  = "${data.template_file.ssh.rendered}"
  filename = "./ssh_config"
}
