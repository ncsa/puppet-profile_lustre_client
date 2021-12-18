# @summary Create bindmounts (generally of Lustre) on a directory
#
# @param map
#   mapping of (Lustre) filesystems to bindmounts
#
#   Example hiera parameter:
# ```
#   profile_lustre_client::bindmounts::map:
#     /scratch:
#       #opts: "defaults,nosuid,nodev,ro"
#       src_mountpoint: "/mnt/mount"
#       src_path: "/mnt/mount/scratch"
# ```
#
# @example
#   include profile_lustre_client::bindmounts
class profile_lustre_client::bindmounts (
  Optional[ Hash ] $map = undef,
) {

  $map.each | $k, $v | {
    profile_lustre_client::bindmount_resource { $k: * => $v }
  }

}
