# cdp-core

<!-- DUBBD v0.3.0 and Zarf v0.28.0 are not latest, so badges are yellow-->
[![Latest Release](https://img.shields.io/github/v/release/bobsled-dev/cdp-core)](https://github.com/bobsled-dev/cdp-core/releases)
[![DUBBD Release](https://img.shields.io/github/v/release/defenseunicorns/uds-package-dubbd?filter=v0.10.0&label=using%20DUBBD)](https://github.com/defenseunicorns/uds-package-dubbd/releases/tag/v0.10.0)
[![MetalLB](https://img.shields.io/github/v/release/defenseunicorns/uds-package-metallb?filter=v0.0.2&label=using%20MetalLB)](https://github.com/defenseunicorns/uds-package-metallb/releases/tag/v0.0.2)
[![Rook-Ceph](https://img.shields.io/github/v/release/defenseunicorns/uds-package-rook-ceph?filter=v0.0.2&label=using%20Rook%20Ceph)](https://github.com/defenseunicorns/uds-package-rook-ceph/releases/tag/v0.0.2)
[![Zarf Release](https://img.shields.io/github/v/release/defenseunicorns/zarf?filter=v0.29.2&label=using%20Zarf)](https://github.com/defenseunicorns/zarf/releases/tag/v0.28.2)

Defense Unicorns Big Bang Distro configured for target environment's.

## Quick Start

### Deploy CDP Core

```
# With Internet
zarf init --components git-server
zarf -a amd64 package deploy oci://ghcr.io/bobsled-dev/packages/cdp-core:vx.y.z-amd64 --confirm

# Without Internet
# Download Release artifacts (zarf, zarf-init-amd64-*.tar.zst, oci://ghcr.io/bobsled-dev/packages/cdp-core:v0.0.3-amd64)
# Move to target system
zarf init --components git-server --confirm # zarf-init-* should be in same directory
zarf package deploy zarf-package-cdp-core-amd64-vx.y.z.tar.zst --confirm
```
```