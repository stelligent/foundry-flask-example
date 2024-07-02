packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "east-builder" {
  region       = "us-east-1"
  source_ami   = "ami-079db87dc4c10ac91"
  instance_type = "t2.xlarge"
  ssh_username = "ec2-user"
  ami_name      = "Flask${formatdate("YYMMDDHHMMss", timestamp())}"
  vpc_id      = "vpc-090e2e0c480a24b6a"
  subnet_id = "subnet-0d523d4efc7cd1515"
}

build {
  sources = [
    "source.amazon-ebs.east-builder",
  ]
  
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3-pip",
      "sudo yum install -y git",
      "sudo mkdir /opt/app",
      "sudo chmod -R 777 /opt/app",
      "cd /opt/app",
      "git clone https://github.com/stelligent/foundry-flask-example.git .",
      "python3 -m venv venv",
      "source venv/bin/activate",
      "pip3 install -r requirements.txt"
    ]
  }
}
