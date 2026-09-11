#!/bin/bash
set -e
IMAGE=${1:-nishal3098/devops-build-dev}
TAG=${2:-latest}
echo "Deploying $IMAGE:$TAG"
docker pull "$IMAGE:$TAG"
docker stop devops-build 2>/dev/null || true
docker rm devops-build 2>/dev/null || true
docker run -d --name devops-build -p 80:80 --restart unless-stopped "$IMAGE:$TAG"
echo "Deployed. App live on port 80."