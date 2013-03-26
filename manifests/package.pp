# = Class: ngircd::package
#
class ngircd::package {

    package{'ngircd':
        ensure => present,
    }
}
