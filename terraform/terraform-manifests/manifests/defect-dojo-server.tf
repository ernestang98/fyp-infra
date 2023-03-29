resource "aws_instance" "defect-dojo-server" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.fyp-subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.fyp-sg.id
  ]
  root_block_device {
    volume_size = var.volume_size
  }
  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install git -y

sudo apt-get install \
     ca-certificates \
     curl \
     gnupg \
     lsb-release -y

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

git clone https://github.com/DefectDojo/django-DefectDojo.git
cd ~/django-DefectDojo
sudo ./dc-build.sh && sudo ./dc-up.sh mysql-rabbitmq &

# ssh into VM and obtain administration password
# sudo docker-compose logs initializer | grep "Admin password"
# admin:vvoCfD47nWaPz6VTAjZ9Fu
# http://defectdojo.fyp-ernest.store:8080/dashboard
EOF
  depends_on = [
    aws_subnet.fyp-subnet-1,
    aws_security_group.fyp-sg
  ]
  tags = {
    Name = "defect-dojo-server"
  }
}
