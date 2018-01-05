#!/bin/sh -ex

rsync -av --delete /haproxy.d/*.cfg /usr/local/etc/haproxy/reverse-proxy/

pkill -HUP -o -e -f '^haproxy\s.*-f\s+/usr/local/etc/haproxy/reverse-proxy/'
