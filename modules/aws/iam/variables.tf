variable "iam_roles" {
  description = "Map of IAM roles with their corresponding policies and services"
  type = map(object({
    service                 = string
    policy_file             = string
    action                  = list(string)
    effect                  = string
    resource                = list(string)
    create_instance_profile = optional(bool, false)
  }))
}