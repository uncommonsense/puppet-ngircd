# = Class: ngircd::config
#
class ngircd::config (
  $admineamil  = 'root@localhost.localdomain',
  $ng_temp_dir = '/tmp',
  $ng_conf_dir = '/etc'
) {
    File {
        owner => 'root',
        group => 'root',
        mode  => '0644',
    }
    file { '/etc/ngircd.conf':
      ensure  => file,
      content => template('ngircd/ngircd.conf.erb'),
      notify  => Service['ngircd'],
    }
}
