# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include tcpdp::install
class tcpdp (
  Boolean $use_static,
  String  $install_dir,
  String  $bin_dir,
  String  $version,
  String  $download_url_base,
){

  include ::tcpdp::install

}
