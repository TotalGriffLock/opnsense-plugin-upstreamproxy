# opnsense-plugin-upstreamproxy
A plugin for when your opnsense firewall must use a proxy to access the internet, and that proxy is not transparent and therefore must be explicitly specified.

This is a bit beta-ish at the moment so use it at your own risk! Run these commands on your firewall to install:

```
curl -LO https://github.com/TotalGriffLock/opnsense-plugin-upstreamproxy/raw/main/os-upstreamproxy-1.0.pkg
pkg add ./os-upstreamproxy-1.0.pkg
```

If your firewall is behind a proxy already and need to give curl the proxy settings to download the pkg, beware that this curl is actually a busybox built in command, not a full version of curl, so the normal curl proxy parameters don't work. This does:
```
env https_proxy=http://proxy_host_name:port curl -LO [....]
```

# TODO
Add a plugin description for the OPNsense gui to display when someone clicks (i)
Add support for NO_PROXY environment variable to allow users to specify URLs NOT to proxy
Use a more standard method of showing/hiding GUI elements rather than my awful javascript
