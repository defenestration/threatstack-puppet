# == Class: threatstack::site
#
# For use by Puppet test-kitchen only.
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
include ::stdlib

if $::operatingsystem == 'Debian' {
  package { 'apt-transport-https':
    ensure => installed,
    before => Class['::threatstackv1']
  }
}

# See .kitchen.yml for setting this fact.
class { '::threatstackv1':
  deploy_key        => $::ts_deploy_key,
  feature_plan      => $::ts_feature_plan,
  agent_config_args => $::ts_config_args,
  package_version   => $::ts_package_version,
}
