#!/bin/bash
set -e
IMAGE=${1:-nishal3098/devops-build-dev}
TAG=${2:-latest}
echo "Building image $IMAGE:$TAG"
docker build -t "$IMAGE:$TAG" .
echo "Build complete: $IMAGE:$TAG"