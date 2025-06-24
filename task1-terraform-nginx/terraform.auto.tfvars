region                 = "us-east-1"
key_name               = "linux-key"
vpc_id                 = "vpc-0bd9dc623176ea677"
ami_id                 = "ami-020cba7c55df1f615"
instance_type          = "t2.micro"
public_key_path        = "~/.ssh/id_rsa.pub"
vpc_security_group_ids = ["sg-05e6ab98841b1681a"]
subnet_id              = "subnet-02dc8073b08e8a044"