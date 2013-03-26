# = Class: ngircd::service
#
class ngircd::service (
  $ng_temp_dir = '/tmp',
  $ng_conf_dir = '/etc'
) {
  exec { 'rebuild-ngircd-conf':
      command     => "/bin/cat ${ngircd::ng_temp_dir}/ngircd/* > ${ngircd::ng_conf_dir}/ngircd.conf",
      refreshonly => true,
      subscribe   => File["${ngircd::ng_temp_dir}/ngircd"],
  }
  service{'ngircd':
      ensure    => running,
      enable    => true,
      subscribe => Exec['rebuild-ngircd-conf'],
  }
}
