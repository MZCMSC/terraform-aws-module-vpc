resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id

  # ingress {
  #   description = "Default SG ingress"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"

  #   self = false
  # }

  # egress {
  #   description = "Default SG Egress"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"

  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = merge(var.tags, tomap({ Name = format("%s-%s-default-sg", var.prefix, var.vpc_name) }))
}