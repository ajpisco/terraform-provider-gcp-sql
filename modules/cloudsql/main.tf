resource "google_sql_database_instance" "main" {
  name                = var.project
  database_version    = var.database_version
  region              = var.region
  encryption_key_name = var.encryption_key_name
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type

    dynamic "backup_configuration" {
      for_each = [local.backup_configuration]
      content {
        enabled                        = backup_configuration.value.enabled
        start_time                     = backup_configuration.value.start_time
        location                       = backup_configuration.value.location
        point_in_time_recovery_enabled = backup_configuration.value.point_in_time_recovery_enabled
        transaction_log_retention_days = backup_configuration.value.transaction_log_retention_days

        dynamic "backup_retention_settings" {
          for_each = backup_configuration.value.retained_backups != null || backup_configuration.value.retention_unit != null ? [var.backup_configuration] : []
          content {
            retained_backups = backup_configuration.value.retained_backups
            retention_unit   = backup_configuration.value.retention_unit
          }
        }
      }
    }

    dynamic "ip_configuration" {
      for_each = [local.ip_configuration]
      content {
        ipv4_enabled       = ip_configuration.value.ipv4_enabled
        private_network    = ip_configuration.value.private_network != null ? ip_configuration.value.private_network : data.google_compute_network.network.self_link
        require_ssl        = ip_configuration.value.require_ssl
        allocated_ip_range = ip_configuration.value.allocated_ip_range

        dynamic "authorized_networks" {
          for_each = ip_configuration.value.authorized_networks
          content {
            expiration_time = lookup(authorized_networks.value, "expiration_time", null)
            name            = lookup(authorized_networks.value, "name", null)
            value           = lookup(authorized_networks.value, "value", null)
          }
        }
      }
    }

    dynamic "location_preference" {
      for_each = var.zone != null ? [1] : []
      content {
        zone           = var.zone
        secondary_zone = var.secondary_zone
      }
    }

    dynamic "password_validation_policy" {
      for_each = [local.password_validation_policy]
      content {
        min_length                  = password_validation_policy.value.min_length
        complexity                  = password_validation_policy.value.complexity
        reuse_interval              = password_validation_policy.value.reuse_interval
        disallow_username_substring = password_validation_policy.value.disallow_username_substring
        password_change_interval    = password_validation_policy.value.password_change_interval
        enable_password_policy      = password_validation_policy.value.enable_password_policy
      }
    }

  }
}

resource "google_sql_database" "database" {
  count   = can(var.database.name) ? 1 : 0
  name       = var.database.name
  charset    = lookup(var.database, "charset", null)
  collation  = lookup(var.database, "collation", null)
  instance   = google_sql_database_instance.main.name
}

resource "random_password" "generated_password" {
  count = var.password == null ? 1 : 0
  length     = 16
  special    = true
}

resource "google_sql_user" "default" {
  name     = var.username
  instance = google_sql_database_instance.main.name
  password = var.password == null ? random_password.generated_password[0].result : var.password
}