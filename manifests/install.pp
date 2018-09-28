# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include tcpdp::install
class tcpdp::install {

  include ::archive

  $_path = "${tcpdp::install_dir}/tcpdp-${tcpdp::version}"

  # URL Examples:
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.9.1/tcpdp_v0.9.1_linux_amd64.el7.tar.gz
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.9.1/tcpdp_v0.9.1_linux_amd64_static.el7.tar.gz
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.9.1/tcpdp_v0.9.1_linux_amd64.xenial.tar.gz
  # * https://github.com/k1LoW/tcpdp/releases/download/v0.9.1/tcpdp_v0.9.1_linux_amd64_static.xenial.tar.gz
  case $facts['kernel'] {
    'Darwin': {
      $_ext = 'zip'
      $_url = "${tcpdp::download_url_base}_darwin_amd64.${_ext}"
    }
    'Linux': {
      $_ext = 'tar.gz'

      $_url_pre = $tcpdp::use_static ? {
        true  => "${tcpdp::download_url_base}_linux_amd64_static",
        false => "${tcpdp::download_url_base}_linux_amd64",
      }

      $_url = $facts['os']['family'] ? {
        'RedHat' => "${_url_pre}.el${facts['os']['release']['major']}.${_ext}",
        'Debian' => "${_url_pre}.${facts['lsbdistcodename']}.${_ext}",
      }
    }
    default: {
      fail("Unsupported kernel: ${facts['kernel']}")
    }
  }

  file { [
    $tcpdp::install_dir,
    $_path,
  ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0555',
    before => Archive["${_path}.${_ext}"],
  }


  archive { "${_path}.${_ext}":
    ensure       => present,
    source       => $_url,
    extract      => true,
    extract_path => $_path,
    creates      => "${_path}/tcpdp",
  }

  file {
    default:
      require => Archive["${_path}.${_ext}"];

    "${_path}/tcpdp":
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0700';

    "${tcpdp::bin_dir}/tcpdp":
      ensure => link,
      target => "${_path}/tcpdp";
  }

}
