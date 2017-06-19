#!/bin/sh -e

rsync -av --delete /haproxy.d/*.cfg /usr/local/etc/haproxy/haproxy.d/

PID="$(pidof haproxy-systemd-wrapper)"
if [ -z "$PID" ]; then
    echo "empty \$PID: '$PID'"
    exit 1
fi

if [ "$PID" -le 1 ]; then
    echo "invalid \$PID: '$PID'"
    exit 1
fi

echo "About to reload process '$PID'"

kill -HUP "$PID"
