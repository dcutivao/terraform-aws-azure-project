variable "vpc_id" {
  description = "ID de la VPC donde se creará el Security Group"
  type        = string
}

# modules/security_group/variables.tf
variable "security_groups" {
  description = "Lista de Security Groups con sus reglas"
  type = list(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
