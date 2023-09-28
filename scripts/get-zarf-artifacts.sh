#!/bin/bash

zarfVersion=$1
echo "Downloading zarf version $zarfVersion"
build_dir=./build
mkdir -p $build_dir
cd $build_dir
curl -0Ls https://github.com/defenseunicorns/zarf/releases/download/$zarfVersion/zarf_$zarfVersion_Linux_amd64 --output zarf
curl -OLs https://github.com/defenseunicorns/zarf/releases/download/$zarfVersion/zarf-init-amd64-$zarfVersion.tar.zst 
cd -