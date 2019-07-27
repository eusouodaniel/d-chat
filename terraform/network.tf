
resource "aws_vpc" "dchat-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "dchat-vpc"
  }
}
resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.dchat-instance.id}"
  vpc      = true

  connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "ec2-user"
    private_key = "${file("${var.aws_pem}")}"
  }

  provisioner "file" {
    source      = "traefik.zip"
    destination = "/home/ec2-user/traefik.zip"
  }

  provisioner "file" {
    source      = "docker-compose.yml"
    destination = "/home/ec2-user/docker-compose.yml"
  }

}

output "dchat_ip" {
  value = "${aws_eip.ip-test-env.public_ip}"
}