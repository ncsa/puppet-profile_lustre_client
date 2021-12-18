# @summary Mount Lustre filesystem on a directory
#
# @example
#   profile_lustre_client::nativemount_resource { '/mnt/mount':
#     src => 'lustre-server1.local@o2ib,lustre-server2.local@o2ib:/filesystem',
#     #opts => 'defaults,nosuid,ro'  ## ??
#   }
#
define profile_lustre_client::nativemount_resource (
  String $src,
  Optional[String] $opts = 'defaults,nodev,nosuid',
) {

  # Resource defaults
  Mount {
    ensure => mounted,
    fstype => 'lustre',
  }
  File {
    ensure => directory,
  }

  # Ensure parents of target dir exist, if needed (excluding / )
  $dirparts = reject( split( $name, '/' ), '^$' )
  $numparts = size( $dirparts )
  if ( $numparts > 1 ) {
    each( Integer[2,$numparts] ) |$i| {
      ensure_resource(
        'file',
        reduce( Integer[2,$i], $name ) |$memo, $val| { dirname( $memo ) },
        { 'ensure' => 'directory' }
      )
    }
  }

  # Ensure target directory exists
  file { $name: }

  # Define the mount point
  mount { $name:
    device  => $src,
    options => $opts,
    require => [
      File[ $name ],
      Package[ $profile_lustre_client::install::required_pkgs ],
    ],
  }

}
