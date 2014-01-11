#!/bin/bash

set -e

IMAGE="localhost:5000/apps/rclive-backend"

docker build -t ${IMAGE} .
docker push ${IMAGE}
