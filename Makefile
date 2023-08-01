VERSION ?= $(if $(shell git describe --tags),$(shell git describe --tags),"UnknownVersion")
ZARF_VERSION = v0.28.2
ZARF_CMD = zarf

.PHONY: help h
h: help
help: ## Display this help information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort | awk 'BEGIN {FS = ":.*?## "}; \
	  {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

download-init: ## Download the Zarf Init package
	curl -OL https://github.com/defenseunicorns/zarf/releases/download/$(ZARF_VERSION)/zarf-init-amd64-$(ZARF_VERSION).tar.zst 

build: ## Build the CDP Core Package
	$(ZARF_CMD) -a amd64 package create --set PACKAGE_VERSION=$(VERSION) --confirm

clean: ## Clean up artifacts
	rm -rf zarf-package*.tar.zst zarf-init*.tar.zst zarf-sbom zarf_v*_amd64 cdp-core-*.tar.zst

release: ## Create a release of the CDP Core Package
	gh release create --generate-notes

zarf-init: download-init ## Install the Zarf Init package on a cluster
	zarf -a amd64 init --components git-server --confirm

zarf-init-remove: ## Remove the Zarf Init package from a cluster
	$(ZARF_CMD) -a amd64 package remove init --confirm

zarf-pkg-deploy: ## Install the CDP Core Package on a cluster
	$(ZARF_CMD) -a amd64 package deploy --confirm zarf-package-cdp-core-amd64*.tar.zst

zarf-pkg-remove: ## Remove the CDP Core Package from a cluster
	$(ZARF_CMD) -a amd64 package remove cdp-core --confirm

cdp-clean: ## Remove files created by cdp-core package, after a failed deployment
	rm -rf run tmp bigbang.dev.cert bigbang.dev.key on_failure.sh terraform.tfstate

get-zarf-linux: ## Download the Zarf Binary used in the current release
	curl -0L https://github.com/defenseunicorns/zarf/releases/download/$(ZARF_VERSION)/zarf_$(ZARF_VERSION)_Linux_amd64 --output zarf_$(ZARF_VERSION)_Linux_amd64

get-zarf-mac: ## Download the Zarf Binary used in the current release
	curl -0L https://github.com/defenseunicorns/zarf/releases/download/$(ZARF_VERSION)/zarf_$(ZARF_VERSION)_Darwin_amd64 --output zarf_$(ZARF_VERSION)_Darwin_amd64

package-all-linux: ## Package release and dependencies
	tar -cf cdp-core-$(VERSION)-all.tar zarf-init-*.tar.zst zarf-package-cdp-core-*.tar.zst zarf_*_Linux_amd64
	zstd cdp-core-$(VERSION)-all.tar

upload-to-s3: ## Upload a package to S3
	aws s3 cp cdp-core-$(VERSION)-all.tar.zst s3://cdp-core/