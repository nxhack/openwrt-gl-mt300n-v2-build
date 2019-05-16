#!/bin/bash -ex

BUILD_DATE=`date +%Y%m%d-%H%M%S`

#
if [ ${EUID:-${UID}} = 0 ]; then
    echo "Do everything as normal user, don't use root user or sudo!"
    exit 255
fi

#CREATE BACKUP DIRECTORY
if [ ! -e 'backups' ]; then
    mkdir backups
fi

#BACKUP LOCAL BUILD KEY
if [ -e 'key-build' ]; then
    cp -n key-build ./backups/
    cp key-build ./backups/key-build.${BUILD_DATE}-$$
fi
if [ -e 'key-build.pub' ]; then
    cp -n key-build.pub ./backups/
    cp key-build.pub ./backups/key-build.pub.${BUILD_DATE}-$$
fi
if [ -e 'key-build.ucert' ]; then
    cp -n key-build.ucert ./backups/
    cp key-build.ucert ./backups/key-build.ucert.${BUILD_DATE}-$$
fi
if [ -e 'key-build.ucert.revoke' ]; then
    cp -n key-build.ucert.revoke ./backups/
    cp key-build.ucert.revoke ./backups/key-build.ucert.revoke.${BUILD_DATE}-$$
fi

#INIT KERNEL CONFIG
if [ ! -e '.config' ]; then
  cp gl-mt300n-v2.config .config
  cp .config ./backups/config.${BUILD_DATE}-$$
fi

#BACKUP DL FOLDER
if [ -e 'dl' ]; then
    mv dl dl.orig
fi

#CLEAN
make clean
make dirclean
make distclean

#RESTORE DL FOLDER
if [ -e 'dl.orig' ]; then
    mv dl.orig dl
fi

#RESTORE LOCAL BUILD KEY
if [ -e 'backups/key-build' ]; then
    cp ./backups/key-build .
fi
if [ -e 'backups/key-build.pub' ]; then
    cp ./backups/key-build.pub .
fi

#FEEDS
./scripts/feeds uninstall -a
rm -rf feeds
./scripts/feeds update -a
./scripts/feeds install -a

# BACKUP FEEDS CONFIG
if [ -e '.config' ]; then
    mv .config ./backups/feeds-config.${BUILD_DATE}-$$
fi

cp gl-mt300n-v2.diffconfig .config
make defconfig
make
