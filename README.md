# opnsense-plugin-upstreamproxy
A plugin for when your opnsense firewall must use a proxy to access the internet, and that proxy is not transparent and therefore must be explicitly specified.

This is a bit beta-ish at the moment so use it at your own risk! Copy the pkg file from this repo onto your firewall and run

```
curl -LO https://github.com/TotalGriffLock/opnsense-plugin-upstreamproxy/raw/main/os-upstreamproxy-1.0.pkg
pkg add ./os-upstreamproxy-1.0.pkg
```

If you are behind a proxy already and need to give curl the proxy settings to download the pkg, beware that this curl is actually a busybox built in command, not a full version of curl, so the normal curl proxy parameters don't work. This does:
```
env https_proxy=http://proxy_host_name:port curl -LO [....]
