#!/usr/local/bin/python3

import configparser
import os

configd_config = configparser.RawConfigParser()
configd_config.optionxform = lambda option: option
configd_config.read('/usr/local/opnsense/service/conf/configd.conf')

message = ""

if os.path.exists('/usr/local/etc/upstreamproxy/upstreamproxy.conf'):

  upstreamproxy_config = configparser.RawConfigParser()
  upstreamproxy_config.optionxform = lambda option: option
  upstreamproxy_config.read('/usr/local/etc/upstreamproxy/upstreamproxy.conf')

  if upstreamproxy_config.has_option('http','http_proxy'):
    configd_config['environment']['http_proxy'] = upstreamproxy_config['http']['http_proxy']
    configd_config['environment']['HTTP_PROXY'] = upstreamproxy_config['http']['http_proxy']
    message += "HTTP proxy settings configured "
  else:
    configd_config.remove_option('environment','http_proxy')
    configd_config.remove_option('environment','HTTP_PROXY')
    message += "HTTP proxy settings cleared "
  if upstreamproxy_config.has_option('https','https_proxy'):
    configd_config['environment']['https_proxy'] = upstreamproxy_config['https']['https_proxy']
    configd_config['environment']['HTTPS_PROXY'] = upstreamproxy_config['https']['https_proxy']
    message += "HTTPS proxy settings configured "
  else:
    configd_config.remove_option('environment','https_proxy')
    configd_config.remove_option('environment','HTTPS_PROXY')
    message += "HTTPS proxy settings cleared "
  if upstreamproxy_config.has_option('ftp','ftp_proxy'):
    configd_config['environment']['ftp_proxy'] = upstreamproxy_config['ftp']['ftp_proxy']
    configd_config['environment']['FTP_PROXY'] = upstreamproxy_config['ftp']['ftp_proxy']
    message += "FTP proxy settings configured "
  else:
    configd_config.remove_option('environment','ftp_proxy')
    configd_config.remove_option('environment','FTP_PROXY')
    message += "FTP proxy settings cleared "

else:

  configd_config.remove_option('environment','http_proxy')
  configd_config.remove_option('environment','HTTP_PROXY')
  configd_config.remove_option('environment','https_proxy')
  configd_config.remove_option('environment','HTTPS_PROXY')
  configd_config.remove_option('environment','ftp_proxy')
  configd_config.remove_option('environment','FTP_PROXY')
  message += "All proxy settings cleared as no proxy config found "

with open('/usr/local/opnsense/service/conf/configd.conf', 'w') as configfile:
  configd_config.write(configfile, space_around_delimiters=False)

stream = os.popen('service configd restart')
message += stream.read()

print('{"message":"' + message + '"}')
