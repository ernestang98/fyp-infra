data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "fyp-model-server" {
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
sudo apt update
sudo apt install apache2 -y
sudo bash -c 'echo "I am working" > /var/www/html/index.html'
sudo systemctl start apache2
sudo systemctl enable apache2

sudo apt install nfs-kernel-server -y
sudo mkdir /var/nfs/general -p
sudo mkdir /var/nfs/minio -p
sudo chown nobody:nogroup /var/nfs/general
sudo chown nobody:nogroup /var/nfs/minio

sudo cat <<EOT >> /etc/exports
/var/nfs/general  0.0.0.0/0(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)
/var/nfs/general  *(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)
/var/nfs/minio  0.0.0.0/0(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)
/var/nfs/minio  *(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)

EOT

sudo exportfs -a
sudo exportfs -s

sudo apt-get install unzip -y

sudo chmod -R 777 /var/nfs/minio
curl -L -o /tmp/models.zip https://www.dropbox.com/sh/t4er3duqizbbxfs/AADMhYjUltQhDv9Of8Eh88TFa?dl=1 && sudo chmod 777 /tmp/models.zip && sudo chmod 777 /var/nfs/general && unzip /tmp/models.zip -x / -d /var/nfs/general && sudo chown -R nobody:nogroup /var/nfs/general* && sudo chmod -R 777 /var/nfs/general &

sudo exportfs -a
sudo exportfs -s
sudo systemctl restart nfs-kernel-server
EOF
  depends_on = [
    aws_subnet.fyp-subnet-1,
    aws_security_group.fyp-sg
  ]
  tags = {
    Name = "fyp-model-server"
  }
}
