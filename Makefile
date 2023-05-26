VERSION ?= $(if $(shell git describe --tags),$(shell git describe --tags),"UnknownVersion")

build:
	zarf package create --set PACKAGE_VERSION=$(VERSION) --confirm

clean:
	rm -rf zarf-package*.tar.zst

release:
	gh release create --generate-notes