#!/bin/sh -ex

haproxy -c -f /haproxy.d/

rsync -av --delete /haproxy.d/ /usr/local/etc/haproxy/reverse-proxy/

pkill -HUP -o -e -f '^haproxy\s.*-f\s+/usr/local/etc/haproxy/reverse-proxy/'
