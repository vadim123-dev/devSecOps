data "aws_ami" "my_dev_ec2" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name   = "name"
      values = ["${var.ami_filter_param}"]
  }
}


# 4. Usage Example (How to use the data you just got)
resource "aws_instance" "example_server" {
  ami           = data.aws_ami.my_dev_ec2.id
  instance_type = "t3.micro"

  tags = {
    Name = "${var.project_tag}"
  }
}


output "aws_instance" {
    value = aws_instance.example_server
}