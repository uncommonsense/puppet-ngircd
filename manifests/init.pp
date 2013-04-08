# = Class: ngircd
#
# == This module manages ngircd
#
# == Parameters
#
# [*servename*]
#   IRC server hostname.
#
# [*listenaddress*]
#   IP Address to bind service to.
#
# [*ng_temp_dir*]
#   Temporary directory for synthesizing ngircd conf files.
#
#  [*ng_conf_dir*]
#    ngircd.conf file directory.
#
#  {*port*]
#    TCP/IP port to bind ngircd service to.
#
# == Actions
#
# == Requires
#
# puppetlab/puppetlabs-stdlib
#
# == Sample Usage
#
# Install ngircd server:
#
# class { 'ngircd':
#   $servername    => 'irc.example.net',
#   $listenaddress => '0.0.0.0'
# }
#
# == Todo
#
# * Convert channel fragments into definitions using augeas lens?
# * Fix puppet-lint issues in channel.pp and service.pp.
# * Add rspec test for configuration of channels & ngircd.conf.
# * Whenever template ngircd.conf.erb is touched ngircd server
#   kicked.
# * Add config file validation using "ngircd --configtest"
#
class ngircd(
    $servername    = 'localhost.localdomain',
    $adminemail    = 'root@localhost.localdomain',
    $listenaddress = '127.0.0.1',
    $ng_temp_dir   = '/tmp',
    $ng_conf_dir   = '/etc',
    $port          = '6667'
){
  Class['ngircd::package'] ->
  Class['ngircd::config'] ->
  Class['ngircd::service']

  anchor { 'ngircd::begin': }
  anchor { 'ngircd::end': }

  class {'ngircd::package':
      require => Anchor['ngircd::begin'],
  }
  class {'ngircd::config':
      ng_temp_dir => $ng_temp_dir,
      ng_conf_dir => $ng_conf_dir,
      require     => Anchor['ngircd::end'],
  }
  class {'ngircd::service':
    ng_temp_dir => $ng_temp_dir,
    ng_conf_dir => $ng_conf_dir,
    require     => Anchor['ngircd::end'],
  }
}
