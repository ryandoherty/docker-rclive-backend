#!/bin/bash

set -e

if [ -z ${MONGO_PORT_27017_TCP_ADDR} ] \
   || [ -z ${MONGO_PORT_27017_TCP_PORT} ] \
   || [ -z ${AWS_ACCESS_KEY} ] \
   || [ -z ${AWS_SECRET_KEY} ]
then 
    echo "missing env config"
    exit 1
fi

sed \
    -e "s#@@MONGO_PORT_27017_TCP_ADDR@@#${MONGO_PORT_27017_TCP_ADDR}#g" \
    -e "s#@@MONGO_PORT_27017_TCP_PORT@@#${MONGO_PORT_27017_TCP_PORT}#g" \
    -e "s#@@AWS_ACCESS_KEY@@#${AWS_ACCESS_KEY}#g" \
    -e "s#@@AWS_SECRET_KEY@@#${AWS_SECRET_KEY}#g" \
    < /var/lib/rclive/rclive-backend.json.in \
    >| /var/run/rclive/rclive-backend.json

exec /opt/rclive/backend/bin/rclive-backend /var/run/rclive/rclive-backend.json
