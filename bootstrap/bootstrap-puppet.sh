wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get -y install puppet
echo "Puppet version: $(puppet --version)"

# See https://tickets.puppetlabs.com/browse/PUP-2566
sed -i "/templatedir/d" /etc/puppet/puppet.conf

# Silence deprecation warning
sed -i "/The use of 'import' is deprecated/d" /usr/lib/ruby/vendor_ruby/puppet/parser/parser_support.rb
