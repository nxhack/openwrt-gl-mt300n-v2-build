#!/bin/bash -ex

git pull origin v22.03.0
./scripts/feeds update -a
./scripts/feeds install -a -f

# If you do not want to change the settings, please comment out.
cp gl-mt300n-v2.diffconfig .config
#cp gl-ar750s-ext.diffconfig .config

make defconfig
make
