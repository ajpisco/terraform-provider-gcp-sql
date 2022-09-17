module "sample" {
  source = "./modules/cloudsql"

  project           = "sample"
  database_version  = "POSTGRES_14"
  region            = "europe-west1"
  zone              = "europe-west1-b"
  secondary_zone    = "europe-west1-d"
  tier              = "db-custom-8-30720"
  availability_type = "REGIONAL"

  backup_configuration = {
    enabled                        = true
    start_time                     = "01:00"
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = 2
    retention_unit                 = 1
    retained_backups               = 2
  }

  ip_configuration = {
    authorized_networks = [{
      name  = "my-ip"
      value = "135.13.51.125/32"
    }]
    ipv4_enabled    = true
    private_network = "projects/ajpisco/global/networks/default"
    require_ssl     = true
    # allocated_ip_range = null
  }

  password_validation_policy = {
    min_length                  = 8
    complexity                  = "COMPLEXITY_DEFAULT"
    reuse_interval              = 3
    disallow_username_substring = true
    password_change_interval    = "2592000s"
    enable_password_policy      = true
  }

  database = {
    name                  = "sample_db"
  }

  username = "myself"
  password = "s0m€$€r10U$P4$$W0rD"

}