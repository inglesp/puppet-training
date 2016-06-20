$static_sites = ["site1", "site2"]
$dynamic_sites = ["site3", "site4"]

package { ["nginx", "curl", "spawn-fcgi", "fcgiwrap"]:
  ensure => installed,
}

service { "nginx":
  ensure => running,
  require => Package["nginx"],
}

file { "/etc/nginx/sites-enabled/default":
  ensure => absent,
}

file { "/var/www":
  ensure => directory,
}

define nginx_site_config() {
  file { "/etc/nginx/sites-available/${name}":
    source => "/vagrant/files/nginx.d/${name}.conf",
    notify => Service["nginx"],
  }

  file { "/etc/nginx/sites-enabled/${name}":
    ensure => "link",
    target => "/etc/nginx/sites-available/${name}",
    notify => Service["nginx"],
  }
}

define static_site_files() {
  file { "/var/www/${name}":
    ensure => directory,
    require => File["/var/www"],
  }

  file { "/var/www/${name}/index.html":
    source => "/vagrant/files/${name}/index.html",
    require => File["/var/www/${name}"],
  }
}

define dynamic_site_files() {
  file { "/var/www/${name}":
    ensure => directory,
    require => File["/var/www"],
  }

  file { "/var/www/${name}/public_html":
    ensure => directory,
    require => File["/var/www/${name}"],
    notify => Service["nginx"],
  }

  file { "/var/www/${name}/logs":
    ensure => directory,
    require => File["/var/www/${name}"],
    notify => Service["nginx"],
  }

  file { "/var/www/${name}/public_html/index.pl":
    source => "/vagrant/files/${name}/index.pl",
    mode => "+x",
  }
}

define dynamic_site_test() {
  exec { "test ${name}":
    command => "/vagrant/tests/test-${name}.sh",
    subscribe => Service["nginx"],
    refreshonly => true,
    logoutput => true,
  }
}

define static_site() {
  nginx_site_config { "${name}": }
  static_site_files { "${name}": }
}

define dynamic_site() {
  nginx_site_config { "${name}": }
  dynamic_site_files { "${name}": }
  dynamic_site_test { "${name}": }
}

static_site { $static_sites: }
dynamic_site { $dynamic_sites: }
