resource "aws_security_group" "nginx" {
  name        = "nginx_SG"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to your IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx Server SG"
  }
}
resource "aws_security_group" "appache" {
  name        = "appache_SG"
  description = "Allow HTTP and SSH traffic from private LB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.private_alb_sg.id] #This will be replaced by the private LB SG
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.private_alb_sg.id] #This will be replaced by the private LB SG

  }
  ingress {
    description     = "Allow SSH from Public EC2"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx.id]  # replace with actual SG
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "appache Server SG"
  }
}
resource "aws_security_group" "public_alb_sg" {
    name = "public_loadbalancer_securitygroup"
    description = "setting sg for public load balancer that allows http and https"
    vpc_id = var.vpc_id
    ingress {
        from_port   =   80
        to_port     =   80
        protocol    =   "tcp"
        cidr_blocks  =   ["0.0.0.0/0"]
    }

    ingress {
        from_port   =   443
        to_port     =   443
        protocol    =   "tcp"
        cidr_blocks  =   ["0.0.0.0/0"]
    }
    egress {
        from_port   =   0
        to_port     =   0
        protocol    =   "-1"
        cidr_blocks  =   ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "private_alb_sg" {
    name = "private_loadbalancer_securitygroup"
    description = "setting sg for private load balancer that allows http and https"
    vpc_id = var.vpc_id
    ingress {
        from_port   =   80
        to_port     =   80
        protocol    =   "tcp"
        security_groups = [aws_security_group.nginx.id]
    }

    ingress {
        from_port   =   443
        to_port     =   443
        protocol    =   "tcp"
        security_groups = [aws_security_group.nginx.id]
    }
    egress {
        from_port   =   0
        to_port     =   0
        protocol    =   "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
