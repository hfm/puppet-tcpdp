require 'beaker-rspec'

logger.error('LOADED Puppet tcpdp Module Spec Acceptance Helper')

# Install Puppet agent on all hosts
install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      install_dev_puppet_module_on(host, source: module_root)
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib', '--version', '4.25.1'))
      on(host, puppet('module', 'install', 'puppet-archive'))

      host[:hieradatadir] = 'hieradata'
      write_hiera_config_on(host, ['%{facts.os.family}', 'common'])
      copy_hiera_data_to(host, File.join(module_root, 'spec', 'fixtures', 'hieradata'))
    end
  end
end
