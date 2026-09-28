#--------------------------------------------------------------
# DNS Zones
#--------------------------------------------------------------
variable "babykalel_domain"         { default = "babykalel.com" }
variable "breakfix_training_domain" { default = "breakfix.training" }
variable "necrux_domain"            { default = "necrux.com" }
variable "weshenderson_domain"      { default = "weshenderson.info" }
variable "tags"                     { default = {} }

#--------------------------------------------------------------
# Kind Records
#--------------------------------------------------------------
variable "kind_server_ip" { default = "192.168.86.67" }

variable "kind_hostnames" {
  description = "Subdomains that should point to the Kind server."
  type        = set(string)
  default     = []
}

#--------------------------------------------------------------
# GitHub Pages Records
#--------------------------------------------------------------
variable "necrux_github_pages_hostnames" {
  description = "Subdomains that should point to www.necrux.com for GitHub Pages sites."
  type        = set(string)
  default     = []
}