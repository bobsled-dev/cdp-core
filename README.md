# cdp-core
Defense Unicorns Big Bang Distro configured for target environment's.

## Quick Start

### Deploy CDP Core
(requires internet access)

```
zarf init --components git-server
zarf -a amd64 package deploy oci://ghcr.io/defenseunicorns/cdp-core:vx.y.z --confirm
```

### Build and Deploy local version
Build the Package: 
```
make build
```

Deploy the Package:
```
# Pre-requisites: k3s cluster (`--disable=traefik --disable=servicelb`)
make download-init # optional - zarf init will download if a network connection exists
make zarf-init
make zarf-pkg-deploy
```

Remove the Package:
```
make zarf-pkg-remove
make zarf-init-remove
```

