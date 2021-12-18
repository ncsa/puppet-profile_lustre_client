# profile_lustre_client

![pdk-validate](https://github.com/ncsa/puppet-profile_lustre_client/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_lustre_client/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - install and configure Lustre client


## Table of Contents

1. [Description](#description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Dependencies](#dependencies)
1. [Reference](#reference)


## Description

This puppet profile customizes a host to install and configure the Lustre client


## Setup

Include profile_lustre_client in a puppet profile file:
```
include ::profile_lustre_client
```


## Usage

The following parameters likely need to be set for any deployment:

```yaml
profile_lustre_client::interface_name: "ib1"
profile_lustre_client::network_identifier: "o2ib0"

profile_lustre_client::firewall::sources:
  - "lustre-server1.local"
  - "lustre-server2.local"

profile_lustre_client::install::yumrepo:
  lustre:
    baseurl: "https://downloads.whamcloud.com/public/lustre/latest-release/el$releasever/client"
    descr: "lustre-client Repository el $releasever - Whamcloud"
    enabled: 1
    #gpgcheck: 1
    #gpgkey: "https://..."

profile_lustre_client::nativemounts::map:
  /mnt/mount:
    src: "lustre-server1.local@o2ib,lustre-server2.local@o2ib:/filesystem"
    opts: "defaults,nodev,nosuid"
```

To include bindmounts you would include parameters like this:

```
profile_lustre_client::bindmounts::map:
  /scratch:
    opts: "defaults,nodev,nosuid"
    src_mountpoint: "/mnt/mount"
    src_path: "/mnt/mount/scratch"
...
```

## Dependencies

n/a


## Reference

See: [REFERENCE.md](REFERENCE.md)
