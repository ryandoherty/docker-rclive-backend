#!/bin/bash

## this is kind of a bullshit way to launch the backend, but it requires no code
## changes for running in Docker.  I should probably extend the config loader to
## read from environment variables natively.

set -e -u

sed \
    -e "s#@@MONGO_PORT_27017_TCP_ADDR@@#${MONGO_PORT_27017_TCP_ADDR}#g" \
    -e "s#@@MONGO_PORT_27017_TCP_PORT@@#${MONGO_PORT_27017_TCP_PORT}#g" \
    -e "s#@@AWS_ACCESS_KEY@@#${AWS_ACCESS_KEY}#g" \
    -e "s#@@AWS_SECRET_KEY@@#${AWS_SECRET_KEY}#g" \
    -e "s#@@S3_BUCKET@@#${S3_BUCKET}#g" \
    -e "s#@@STATSD_HOST@@#${STATSD_HOST}#g" \
    -e "s#@@STATSD_PORT@@#${STATSD_PORT}#g" \
    < /var/lib/rclive/rclive-backend.json.in \
    >| /var/run/rclive/rclive-backend.json

exec /opt/rclive/backend/bin/rclive-backend /var/run/rclive/rclive-backend.json
