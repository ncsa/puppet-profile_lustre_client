# @summary Install and configure Lustre client
#
# @param interface_name
#   Name of network interface that lustre should use
#
# @param network_identifier
#   LNet Network Identifier (NID) - includes Lustre Network Driver (LND) and LND network number
#   e.g. IB fabrics are generally "o2ib0" while Ethernet are "tcp0"
#
# @example
#   include profile_lustre_client
class profile_lustre_client (
  String $interface_name,
  String $network_identifier,
) {

  include ::profile_lustre_client::bindmounts
  include ::profile_lustre_client::firewall
  include ::profile_lustre_client::install
  include ::profile_lustre_client::module
  include ::profile_lustre_client::nativemounts
  include ::profile_lustre_client::service

}
