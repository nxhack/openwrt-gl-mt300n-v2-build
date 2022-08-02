# OpenWrt mocha firmware for GL.iNet GL-MT300N-V2

## Description
[GL.iNet](https://www.gl-inet.com/) [GL-MT300N-V2](https://www.gl-inet.com/products/gl-mt300n-v2/) is cheap Wi-Fi router. However, it is good hardware that OpenWrt works easily.

## Reference
- [Hardware Specification](https://docs.gl-inet.com/en/3/hardware/mt300n-v2/)
- [OpenWrt](https://openwrt.org/toh/hwdata/gl.inet/gl.inet_gl-mt300n_v2)
- [OpenWrt:Techdata](https://openwrt.org/toh/gl.inet/gl-mt300n_v2)

## Build
Build firmware on **your Docker environment.**

```bash
mkdir Build_Path_Some_Where
cd Build_Path_Some_Where
git clone https://github.com/nxhack/openwrt-gl-mt300n-v2-build.git
cd openwrt-gl-mt300n-v2-build
docker build -t gl:1 .
docker run -it gl:1
cd openwrt
./build.sh
```
**It will take several hours.**

## Setup
### Shadowsocks
- [forward all](https://github.com/openwrt/packages/tree/master/net/shadowsocks-libev#recipes)
- [SIP003 plugin based on v2ray](https://github.com/shadowsocks/v2ray-plugin)
- [v2ray-plugin OpenWrt custom package](https://github.com/nxhack/openwrt-custom-packages/tree/master/v2ray-plugin)

### DNS over TLS
- [stubby](https://openwrt.org/docs/guide-user/services/dns/stubby)
- [Privacy-Protecting Portable Router: Adding DNS-Over-TLS support to OpenWRT (LEDE) with Unbound](https://blog.cloudflare.com/dns-over-tls-for-openwrt/)
- [Configuring DNS over TLS with LuCI using Stubby and Dnsmasq](https://forum.openwrt.org/t/tutorial-no-cli-configuring-dns-over-tls-with-luci-using-stubby-and-dnsmasq/29143)


### TCP BBR
```
CONFIG_PACKAGE_kmod-sched=y
CONFIG_PACKAGE_kmod-tcp-bbr=y
```

```bash
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.core.default_qdisc=fq
```

### TCP FAST OPEN
```bash
sysctl -w net.ipv4.tcp_fastopen=3
```
