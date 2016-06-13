This repo contains code to set up, provision, and test a Vagrant VM with Puppet.

Instructions:

* Clone this repo
* From the repo's root directory, run `vagrant up`
  * This will:
    * Download the [hashicorp/precise64](https://atlas.hashicorp.com/hashicorp/boxes/precise64) base box if required
    * Create and configure a guest machine using this base box
    * Install the most recent version of Puppet 3 inside the guest machine
    * Create a test file inside the guest machine using Puppet
  * You should see the following towards the end of the output:

```
Puppet version: 3.8.7
...snip...
==> default: Running Puppet with default.pp...
...snip...
==> default: Notice: Compiled catalog for precise64.home in environment production in 0.07 seconds
==> default: Notice: /Stage[main]/Main/File[/tmp/hello]/ensure: defined content as '{md5}a7966bf58e23583c9a5a4059383ff850'
==> default: Notice: Finished catalog run in 0.03 seconds
```


  * When this completes, run `vagrant ssh`
    * This will launch an SSH session to connect to the new guest machine
  * From the SSH session, run `cat /tmp/hello`
    * You should see:

```
    $ cat /tmp/hello 
    Hello, world
```

  * You can now close the SSH session and run `vagrant halt` to shut down the guest machine
