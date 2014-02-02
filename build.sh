#!/bin/bash

set -e

IMAGE="zardoz.podzone.org:11003/apps/rclive-backend"

docker build -t ${IMAGE} .
docker push ${IMAGE}
