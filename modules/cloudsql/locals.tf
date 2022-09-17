locals {
  backup_configuration = merge(
    {
      enabled                        = false
      start_time                     = null
      location                       = null
      point_in_time_recovery_enabled = false
      transaction_log_retention_days = null
      retained_backups               = null
      retention_unit                 = null
    },
    var.backup_configuration,
  )

  ip_configuration = merge(
    {
      authorized_networks = []
      ipv4_enabled        = true
      private_network     = null
      require_ssl         = null
      allocated_ip_range  = null
    },
    var.ip_configuration,
  )

  password_validation_policy = merge(
    {
      min_length                  = null
      complexity                  = null
      reuse_interval              = null
      disallow_username_substring = null
      password_change_interval    = null
      enable_password_policy      = false
    },
    var.password_validation_policy,
  )
}