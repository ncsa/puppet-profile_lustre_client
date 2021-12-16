# @summary Install Lustre client
#
# @param required_pkgs
#   Packages that need to be installed for Lustre mounts to work.
#
# @param yumrepo
#   Hash of yumrepo resource for lustre yum repository
#
# @example
#   include profile_lustre_client::install
class profile_lustre_client::install (
  Array[ String ] $required_pkgs,
  Hash            $yumrepo,
) {

  $yumrepo_defaults = {
    ensure  => present,
    enabled => true,
  }
  ensure_resources( 'yumrepo', $yumrepo, $yumrepo_defaults )

  $packages_defaults = {
  }
  ensure_packages( $required_pkgs, $packages_defaults )

}
