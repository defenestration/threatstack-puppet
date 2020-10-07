# == Class: threatstack::yum
#
# Setup Threat Stack YUM repo.
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
# Copyright 2016 Threat Stack, Inc.
#
class threatstackv1::yum {
  Exec {
    path => ['/bin', '/usr/bin']
  }

  # Handle setups where wget is defined but with different attributes. This
  # should be fixed sometime in 4.15.x or 4.16.x of stdlib.  Fix is in master
  # but not released.
  if !defined(Package['wget']) {
    # Our site only supports TLS > 1.0 which curl, used by yum, does not support
    # in RHEL 6.  We use wget because even better, the --tlsv1 flag to curl does
    # not work before 6.7.
    ensure_packages('wget')
  }

  exec { 'ts-gpg-fetch':
    command => "wget ${::threatstackv1::gpg_key} -O ${::threatstackv1::gpg_key_file}",
    creates => $::threatstackv1::gpg_key_file
  }

  yumrepo { 'threatstack':
    descr    => 'Threat Stack Package Repository',
    enabled  => 1,
    baseurl  => $::threatstackv1::repo_url,
    gpgcheck => 1,
    gpgkey   => $::threatstackv1::gpg_key_file_uri,
    require  => Exec['ts-gpg-fetch']
  }
}
