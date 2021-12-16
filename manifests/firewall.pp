# @summary A short summary of the purpose of this class
#
# @param dports
#   Destination ports that need to be open for the lustre service
#
# @param proto
#   Protocol that needs to be open for the lustre service
#
# @param sources
#   CIDR sources that need to be open for the lustre service.
#   This should include all of the Lustre servers and any LNET routers.
#   It may also need to other lustre client peers (need confirmation about this).
#
# @example
#   include profile_lustre_client::firewall
class profile_lustre_client::firewall (
  Array[Integer]  $dports,
  String          $proto,
  Array[String]   $sources,
) {

  $iniface = lookup('profile_lustre_client::interface_name', String)

  $sources.each | $location, $source |
  {
    firewall { "200 allow Lustre via ${proto} from ${source}":
      proto   => $proto,
      dport   => $dports,
      iniface => $iniface,
      source  => $source,
      action  => 'accept',
    }
  }

}
