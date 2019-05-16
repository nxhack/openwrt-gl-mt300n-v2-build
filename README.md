# OpenWrt vanilla firmware for GL.iNet GL-MT300N-V2
## Description

[GL.iNet](https://www.gl-inet.com/) [GL-MT300N-V2](https://www.gl-inet.com/products/gl-mt300n-v2/) is cheap Wi-Fi router. However, it is good hardware that OpenWrt works easily.


[Hardware Specification](https://docs.gl-inet.com/en/3/hardware/mt300n-v2/)

[OpenWrt](https://openwrt.org/toh/hwdata/gl.inet/gl.inet_gl-mt300n_v2)

[OpenWrt:Techdata](https://openwrt.org/toh/gl.inet/gl.inet_gl-mt300n_v2)

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
