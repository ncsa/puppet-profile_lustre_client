# @summary Configure the lnet service
#
# @param lnet_service_enabled
#   Boolean to determine if the lnet service is enabled
#
# @param lnet_service_name
#   String of the name of the lnet service
#
# @param lnet_service_running
#   Boolean to determine if the lnet service is ensured running
#
# @example
#   include profile_lustre_client::service
class profile_lustre_client::service (
  Boolean $lnet_service_enabled,
  String $lnet_service_name,
  Boolean $lnet_service_running,
) {

  service { $lnet_service_name:
    ensure  => $lnet_service_running,
    enable  => $lnet_service_enabled,
    require => [
      Package[ $profile_lustre_client::install::required_pkgs ],
    ],
  }


}
