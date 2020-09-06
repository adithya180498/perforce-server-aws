################################################
#  AWS Security Groups Perforce Server        
#  by Simon Stockhause 
################################################

# HTTP-Related-Traffic Security Group
resource "aws_security_group" "http" {
  name        = "http public security group"
  description = "Allow inbound HTTP traffic"
  vpc_id      = "${aws_vpc.perforce_server_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http public security group"
  }
}
# SSH Security Group
resource "aws_security_group" "ssh" {
  name        = "ssh public security group"
  description = "Allow inbound SSH traffic"
  vpc_id      = "${aws_vpc.perforce_server_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${var.cidr}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh public security group"
  }
}
# perforce_server_SG Application Security Group
# Defines Applicationsspecific Ports As Accessable 
resource "aws_security_group" "perforce_server_SG" {
  name        = "perforce_server_SG public security group"
  description = "Allow inbound HTTP traffic"
  vpc_id      = "${aws_vpc.perforce_server_vpc.id}"

  ingress {
    from_port   = 1666
    to_port     = 1666
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "perforce_server_SG Application Ports"
  }
}

