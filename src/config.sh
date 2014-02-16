#!/bin/bash

set -e
set -x

cd /tmp/src

## make sure there's only one package
if [ $( ls /tmp/work/node-rclive-backend*.rpm | wc -l ) -ne 1 ]; then
    echo "expected to find exactly one package"
    exit 1
fi

useradd -r rclive

mkdir -p /var/{log,lib,spool}/rclive /var/run/rclive/zmq_sockets

mv rclive-backend.json /var/lib/rclive/rclive-backend.json.in
mv launch-rclive-backend.sh /usr/local/bin/

mv program-*.conf /etc/supervisor.d/
mv logstash-forwarder-*.json /etc/logstash-forwarder.d/

mv logrotate-rclive-backend.conf /etc/logrotate.d/rclive-backend

chown -R rclive:rclive /var/{log,run,spool}/rclive

yum localinstall -y /tmp/work/node-rclive-backend*.rpm
chmod +x /opt/rclive/backend/bin/rclive-backend

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src /tmp/work
