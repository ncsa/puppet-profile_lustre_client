# @summary Mount Lustre filesystems on the client
#
# @param map
#   mapping of Lustre filesystems to local mount points
#
#   Example hiera parameter:
# ```
#   profile_lustre_client::nativemounts::map:
#     /mnt/mount:
#       src: "lustre-server1.local@o2ib,lustre-server2.local@o2ib:/filesystem"
#       #opts: "defaults,nosuid,ro"  ## ??
# ```
#
# @example
#   include profile_lustre_client::nativemounts
class profile_lustre_client::nativemounts (
  Optional[ Hash ] $map = undef,
) {

  $map.each | $k, $v | {
    profile_lustre_client::nativemount_resource { $k: * => $v }
  }

}
