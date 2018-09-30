# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include tcpdp::install
class tcpdp (
  String  $install_dir,
  String  $bin_dir,
  String  $version,
  String  $download_url_base,
  String  $pidfile,
  String  $dumper,
  String  $target,
  String  $interface,
  Boolean $use_server_starter,
  String  $listen_addr,
  String  $remote_addr,
  String  $log_dir,
  Boolean $log_enable,
  Boolean $log_stdout,
  String  $log_format,
  Boolean $log_rotate_enable,
  String  $log_rotation_time,
  Integer $log_rotation_count,
  String  $dumplog_dir,
  Boolean $dumplog_enable,
  Boolean $dumplog_stdout,
  String  $dumplog_format,
  Boolean $dumplog_rotate_enable,
  String  $dumplog_rotation_time,
  Integer $dumplog_rotation_count,
){

  include ::tcpdp::install
  include ::tcpdp::config

}
