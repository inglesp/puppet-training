$users = ["alice", "bob"]
$shells = {
  "alice" => "/bin/bash",
  "bob" => "/bin/sh",
}

define set_up_user() {
  user { "${name}":
    home => "/home/${name}",
    managehome => true,
    shell => $shells[$name];
  }

  ssh_authorized_key { "${name}'s key":
    user => "${name}",
    type => "rsa",
    key => file("/tmp/${name}.pub"),
    require => User["${name}"],
  }
}

set_up_user { $users: }
