resource "aws_instance" "dchat-instance" {
  ami           = "${var.ami_id}"
  instance_type = "${var.aws_instance}"
  key_name      = "${var.ami_key_pair_name}"

  user_data = <<-EOF
              yum update -y
              yum install -y docker
              service docker start
              usermod -aG docker $USER
              service docker restart
              yum install python-pip -y
              pip install docker-compose
              EOF

  security_groups = ["${aws_security_group.ingress-all-test.id}"]
	tags {
    Name = "${var.ami_name}"
  }
	subnet_id = "${aws_subnet.subnet-uno.id}"  
}