package { "nginx":
  ensure => installed,
}

package { "curl":
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

file { "/etc/nginx/sites-available/site1":
  source => "/vagrant/files/nginx.d/site1.conf",
  notify => Service["nginx"],
}

file { "/etc/nginx/sites-enabled/site1":
  ensure => "link",
  target => "/etc/nginx/sites-available/site1",
  notify => Service["nginx"],
}

file { "/var/www/site1":
  ensure => directory,
  require => File["/var/www"],
}

file { "/var/www/site1/index.html":
  source => "/vagrant/files/site1/index.html",
}

file { "/etc/nginx/sites-available/site2":
  source => "/vagrant/files/nginx.d/site2.conf",
  notify => Service["nginx"],
}

file { "/etc/nginx/sites-enabled/site2":
  ensure => "link",
  target => "/etc/nginx/sites-available/site2",
  notify => Service["nginx"],
}

file { "/var/www/site2":
  ensure => directory,
  require => File["/var/www"],
}

file { "/var/www/site2/index.html":
  source => "/vagrant/files/site2/index.html",
}

package { "spawn-fcgi":
  ensure => installed,
}

package { "fcgiwrap":
  ensure => installed,
}

file { "/etc/nginx/sites-available/site3":
  source => "/vagrant/files/nginx.d/site3.conf",
  require => File["/var/www/site3/logs"],
  notify => Service["nginx"],
}

file { "/etc/nginx/sites-enabled/site3":
  ensure => "link",
  target => "/etc/nginx/sites-available/site3",
  notify => Service["nginx"],
}

file { "/var/www/site3":
  ensure => directory,
  require => File["/var/www"],
}

file { "/var/www/site3/public_html":
  ensure => directory,
  require => File["/var/www/site3"],
}

file { "/var/www/site3/logs":
  ensure => directory,
  require => File["/var/www/site3"],
}

file { "/var/www/site3/public_html/index.pl":
  source => "/vagrant/files/site3/index.pl",
  mode => "o+x",
}

exec { "test site3":
  command => "/vagrant/tests/test-site3.sh",
  subscribe => Service["nginx"],
  refreshonly => true,
  logoutput => true,
}

file { "/etc/nginx/sites-available/site4":
  source => "/vagrant/files/nginx.d/site4.conf",
  require => File["/var/www/site4/logs"],
  notify => Service["nginx"],
}

file { "/etc/nginx/sites-enabled/site4":
  ensure => "link",
  target => "/etc/nginx/sites-available/site4",
  notify => Service["nginx"],
}

file { "/var/www/site4":
  ensure => directory,
  require => File["/var/www"],
}

file { "/var/www/site4/public_html":
  ensure => directory,
  require => File["/var/www/site4"],
  notify => Service["nginx"],
}

file { "/var/www/site4/logs":
  ensure => directory,
  require => File["/var/www/site4"],
  notify => Service["nginx"],
}

file { "/var/www/site4/public_html/index.pl":
  source => "/vagrant/files/site4/index.pl",
  mode => "+x",
}

exec { "test site4":
  command => "/vagrant/tests/test-site4.sh",
  subscribe => Service["nginx"],
  refreshonly => true,
  logoutput => true,
}
