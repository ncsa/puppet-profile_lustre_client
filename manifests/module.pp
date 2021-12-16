# @summary Configure and build lnet & lustre kernel modules
#
# @param lnet_conf_file
#   Full path to lnet.conf file, e.g. "/etc/lnet.conf"
#
# @param modprobe_lustre_conf_file
#   Full path to modprobe lustre.conf file, e.g. "/etc/modprobe.d/lustre.conf"
#
# @example
#   include profile_lustre_client::module
class profile_lustre_client::module (
  String $lnet_conf_file,
  String $modprobe_lustre_conf_file,
) {

  $interface_name = lookup('profile_lustre_client::interface_name', String)
  $network_identifier = lookup('profile_lustre_client::network_identifier', String)

  # BUILD /etc/modprobe.d/lustre.conf FILE
  file { $modprobe_lustre_conf_file:
    ensure  => file,
    content => epp( 'profile_lustre_client/lustre.conf.epp' ),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  # BUILD lnet.conf FILE
  $build_lnet_conf_command = "modprobe lnet && lnetctl lnet configure --all && \
    lnetctl export --backup > ${lnet_conf_file}"
  exec { 'build_lnet_conf':
    command => $build_lnet_conf_command,
    creates => $lnet_conf_file,
    unless  => "grep ${interface_name} ${lnet_conf_file} && grep ${network_identifier} ${lnet_conf_file}",
    path    => ['/usr/bin', '/usr/sbin', '/sbin'],
    require => [
      Package[ $profile_lustre_client::install::required_pkgs ],
    ],
  }

  # ENABLE lustre MODULE
  exec { 'modprobe_lustre':
    command   => 'modprobe lustre',
    unless    => 'lsmod | grep lustre',
    path      => ['/usr/bin', '/usr/sbin', '/sbin'],
    subscribe => Exec['build_lnet_conf'],
    require   => [
      Package[ $profile_lustre_client::install::required_pkgs ],
    ],
  }

}
