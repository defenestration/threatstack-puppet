# == Class: threatstack::v1::apt
#
# Setup Threat Stack APT repo.
#
# === Examples
#
# This class is not meant to be directly realized outside of
# Class['::threatstack'].
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack
#
class threatstack::v1::apt {
  $apt_source_file = '/etc/apt/sources.list.d/threatstack.list'

  Exec {
    path => ['/bin', '/usr/bin']
  }

  # Handle setups where curl is defined but with different attributes. This
  # should be fixed sometime in 4.15.x or 4.16.x of stdlib.  Fix is in master
  # but not released.
  if !defined(Package['curl']) {
    ensure_packages('curl')
  }

  file { $apt_source_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "deb ${threatstack::v1::repo_url} ${::lsbdistcodename} main",
    notify  => Exec['ts-agent-apt-get-update']
  }

  exec { 'ts-agent-apt-get-update':
    command     => 'apt-get update',
    refreshonly => true
  }

  exec { 'ts-gpg-import':
    command => "curl ${threatstack::v1::gpg_key} | apt-key add -",
    unless  => 'apt-key list | grep "Threat Stack"',
    notify  => Exec['ts-agent-apt-get-update'],
    require => Package['curl']
  }
}
