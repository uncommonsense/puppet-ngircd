# = Class: ngircd::service
#
class ngircd::service (
  $ng_temp_dir = '/tmp',
  $ng_conf_dir = '/etc'
) {
  service{'ngircd':
      ensure    => running,
      enable    => true,
  }
}
