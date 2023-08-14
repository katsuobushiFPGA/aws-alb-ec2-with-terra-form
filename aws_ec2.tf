resource "aws_instance" "public_app_server" {
  ami           = "ami-0e0166ef4456f252a" #AmazonLinux2023 (arm)
  instance_type = "t4g.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.ec2_key.key_name
  user_data     = file("./files/user_data.sh")

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id
  ]

  tags = {
    Name = "SamplePublicEC2Instance"
  }
}

resource "aws_instance" "private_app_server" {
  ami           = "ami-0e0166ef4456f252a" #AmazonLinux2023 (arm)
  instance_type = "t4g.micro"
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = aws_key_pair.ec2_key.key_name
  user_data     = file("./files/user_data.sh")

  vpc_security_group_ids = [
    aws_security_group.alb.id,
    aws_security_group.for_private_ssh.id
  ]

  tags = {
    Name = "SamplePrivateEC2Instance"
  }
}

# キーペア
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-ssh-key"
  public_key = "ssh-ed25519 XXXXXXXXXXXXXX" # 事前に作成した公開鍵を貼り付ける
}