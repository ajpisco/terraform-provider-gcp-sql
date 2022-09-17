variable "project" {
  type        = string
  description = "Name to be used by the SQL"
}

variable "database_version" {
  type        = string
  description = "The database version to use"
  default     = "POSTGRES_14"
}

variable "region" {
  type        = string
  description = "The region of the Cloud SQL resources"
}

variable "zone" {
  type        = string
  description = "The zone of the Cloud SQL resources"
  default     = null
}

variable "secondary_zone" {
  type        = string
  description = "The secondary zone of the Cloud SQL resources"
  default     = null
}

// Default value is suitable for dev environments only.
// For Production, this variable should be set
variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-f1-micro"
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance"
  type        = bool
  default     = false
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)"
  type        = string
  default     = "ZONAL"
}

variable "collation" {
  description = "The name of server instance collation"
  type        = string
  default     = "en_US.UTF8"
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  # Default values are set in locals.tf
  default = {}
}

variable "ip_configuration" {
  description = "The IP configuration for the master instances."
  # Default values are set in locals.tf
  default = {}
}

variable "password_validation_policy" {
  description = "Setting password policy at the instance level"
  # Default values are set in locals.tf
  default = {}
}

variable "database" {
  description = "Database configuration"
  # Default values are set in locals.tf
  default = {}
}

variable "username" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

variable "password" {
  description = "The password for the default user. If not set, a random one will be generated (can be overwritten in the console)"
  type        = string
  default     = null
}

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }

# variable "" {
#   description = ""
#   type        = string
#   default     = null
# }