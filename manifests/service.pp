# == Class: threatstackv1::service
#
# Manage the Threat Stack agent service
#
# === Authors
#
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#
class threatstackv1::service {

  # NOTE: We do not signal the cloudsight service to restart via the package
  # resource because the workflow differs between fresh installation and
  # upgrades.  The package scripts will handle this.
  service { $::threatstackv1::ts_service:
    ensure     => running,
    enable     => true,
    hasrestart => true
  }

}

