#
# References:
#  https://hub.docker.com/r/yhnw/openwrt-sdk/dockerfile
#  https://hub.docker.com/r/fasheng/openwrt-buildsdk/dockerfile
#

FROM debian:bookworm

MAINTAINER Hirokazu MORIKAWA <morikw2@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ADD debian.sources /etc/apt/sources.list.d/

## FIX - RPC failed; curl 56 GnuTLS recv error (-110)
ENV GIT_VERSION 2.39.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    fakeroot \
    dpkg-dev \
    git
RUN apt-get update && apt-get build-dep -y  \
    git
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev
WORKDIR /opt/git/source-git
RUN apt-get update && apt-get source -y \
    git \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/git/source-git/git-${GIT_VERSION}/
RUN sed -i -- 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/' ./debian/control \
 && sed -i -- '/TEST\s*=\s*test/d' ./debian/rules \
 && dpkg-buildpackage -rfakeroot -b -uc -us \
 && dpkg -i ../git_*.deb

## START
RUN apt-get update && apt-get install -y apt-utils && apt-get -y upgrade && \
apt-get install -y build-essential clang flex bison g++ gawk gnupg \
        gcc-multilib g++-multilib gettext libncurses-dev libssl-dev \
        python3-distutils rsync unzip zlib1g-dev file wget sudo && \
apt-get -y autoremove && apt-get clean && \
useradd -c "OpenWrt Builder" -m -d /home/openwrt -s /bin/bash openwrt && \
echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

USER openwrt
ENV HOME /home/openwrt
WORKDIR /home/openwrt

RUN git clone -b v22.03.0 https://github.com/openwrt/openwrt.git
ADD --chown=openwrt:openwrt *.diffconfig *.config *.sh ./openwrt/
RUN chmod +x ./openwrt/*.sh

#
# For the first time build:
#   'cd openwrt; ./build.sh'
#
# From the next time build:
#   'cd openwrt; ./rebuild.sh
#

CMD ["/bin/bash"]
