# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include tcpdp::install
class tcpdp::install {

  # URL Examples:
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.10.0/tcpdp-0.10.0-1.el6.x86_64.rpm
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.10.0/tcpdp_0.10.0-1_amd64.deb

  $_url = $facts['os']['family'] ? {
    'RedHat' => "${tcpdp::download_url_base}/tcpdp-${tcpdp::version}-1.el${facts['os']['release']['major']}.x86_64.rpm",
    'Debian' => "${tcpdp::download_url_base}/tcpdp_${tcpdp::version}-1_amd64.deb",
  }

  $_provider = $facts['os']['family'] ? {
    'RedHat' => 'rpm',
    'Debian' => 'dpkg',
  }

  package { 'tcpdp':
    ensure   => present,
    source   => $_url,
    provider => $_provider,
  }

}
