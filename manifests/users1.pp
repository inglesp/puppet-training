user { "alice":
  home => "/home/alice",
  managehome => true,
  shell => "/bin/bash",
}

user { "bob": 
  home => "/home/bob",
  managehome => true,
  shell => "/bin/sh",
}

ssh_authorized_key { "alice's key":
  user => "alice",
  type => "rsa",
  key => file("/tmp/alice.pub"),
  require => User["alice"],
}

ssh_authorized_key { "bob's key":
  user => "bob",
  type => "rsa",
  key => file("/tmp/bob.pub"),
  require => User["bob"],
}
