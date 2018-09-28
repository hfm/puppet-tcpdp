# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include tcpdp::config
class tcpdp::config {

  file { '/etc/tcpdp.toml':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('tcpdp/tcpdp.toml.epp'),
  }

}
