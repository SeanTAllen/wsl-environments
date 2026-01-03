#!/bin/bash

set -o errexit
set -o nounset

DOCKERFILE_DIR="$(dirname "$0")"
NAME="ghcr.io/seantallen/wsl-environments-arch-daily-feb2025"

# with date as tag
TAG_AS=$(date +%Y%m%d)
docker build --pull -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"

# with latest as tag
TAG_AS="latest"
docker build --pull -t "${NAME}:${TAG_AS}" "${DOCKERFILE_DIR}"
docker push "${NAME}:${TAG_AS}"
