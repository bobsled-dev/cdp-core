VERSION ?= $(if $(shell git describe --tags),$(shell git describe --tags),"UnknownVersion")
ZARF_VERSION = v0.29.2
ZARF_CMD = zarf

.PHONY: help h
h: help
help: ## Display this help information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort | awk 'BEGIN {FS = ":.*?## "}; \
	  {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

get-zarf-artifacts: ## Download the Zarf Init package and binary
	scripts/get-zarf-artifacts.sh $(ZARF_VERSION)

build: ## Build the CDP Core Package
	$(ZARF_CMD) -a amd64 package create --set PACKAGE_VERSION=$(VERSION) --confirm

clean: ## Clean up the build artifacts
	rm -rf zarf-package*.tar.zst zarf-init*.tar.zst zarf-sbom build