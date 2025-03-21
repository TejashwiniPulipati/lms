module "lms_vpc" {
  source             = "./modules/VPC"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "eu-west-2a"
  vpc_name           = "lms"
}

module "lms_ec2" {
  source                 = "./modules/EC2"
  ami                    = "ami-04da26f654d3383cf"
  instance_type          = "t2.micro"
  subnet_id              = module.lms_vpc.public_subnet.id
  vpc_security_group_ids = [module.lms_vpc.public_sg.id]
  key_name               = "awskey"
  user_data              = file("lms.sh")
  instance_name          = "lms-server"
}

output "lms_instance_ip" {
    value = module.lms_ec2.instance_ip
}
