variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type (t3.micro is usually free-tier eligible)"
  type        = string
  default     = "t3.micro"
}

variable "project_tag" {
  description = "Value of the Project tag. The PowerShell scripts filter on this."
  type        = string
  default     = "CloudCostOptimization"
}

variable "public_key_path" {
  description = "Path to your SSH PUBLIC key file"
  type        = string
  default     = "~/.ssh/cost-opt-key.pub"
}

variable "admin_cidr" {
  description = "IP range allowed to reach SSH, Grafana and Prometheus. Use YOUR_IP/32."
  type        = string
  default     = "0.0.0.0/0"
}
