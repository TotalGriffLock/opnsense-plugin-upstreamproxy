# opnsense-plugin-upstreamproxy
A plugin for when your opnsense firewall must use a proxy to access the internet, and that proxy is not transparent and therefore must be explicitly specified.

This is a bit beta-ish at the moment so use it at your own risk! Copy the pkg file from this repo onto your firewall and run

```
pkg add ./os-upstreamproxy-1.0.pkg
