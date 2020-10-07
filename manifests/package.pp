# == Class: threatstack::package
#
# Install Threat Stack Agent package.
#
# === Examples
#
# class threatstack ( .. ) inherits threatstack::params { .. }
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#
class threatstack::v1::package {

  class { $::threatstack::v1::repo_class: }

  # NOTE: We do not signal the cloudsight service to restart because the
  # package takes care of this.  The workflow differs between fresh
  # installation and upgrades.
  package { $::threatstack::v1::ts_package:
    ensure  => $::threatstack::v1::package_version,
    require => Class[$::threatstack::v1::repo_class]
  }

}
