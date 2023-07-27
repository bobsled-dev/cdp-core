# cdp-core

<!-- DUBBD v0.3.0 and Zarf v0.28.0 are not latest, so badges are yellow-->
[![Latest Release](https://img.shields.io/github/v/release/bobsled-dev/cdp-core)](https://github.com/bobsled-dev/cdp-core/releases)
[![DUBBD Release](https://img.shields.io/github/v/release/defenseunicorns/uds-package-dubbd?filter=v0.4.2&label=using%20DUBBD)](https://github.com/defenseunicorns/uds-package-dubbd/releases/tag/v0.4.2)
[![Zarf Release](https://img.shields.io/github/v/release/defenseunicorns/zarf?filter=v0.28.2&label=using%20Zarf)](https://github.com/defenseunicorns/zarf/releases/tag/v0.28.2)

Defense Unicorns Big Bang Distro configured for target environment's.

## Quick Start

### Deploy CDP Core
(requires internet access)

```
zarf init --components git-server
zarf -a amd64 package deploy oci://ghcr.io/bobsled-dev/packages/cdp-core:vx.y.z-amd64 --confirm
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