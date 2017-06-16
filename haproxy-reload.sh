#!/bin/sh -e

SOURCE="/haproxy.d/"
DEST="/usr/local/etc/haproxy/haproxy.d/"

rsync -av --delete "$SOURCE" "$DEST"

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
