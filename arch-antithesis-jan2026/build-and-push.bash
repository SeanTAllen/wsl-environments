#!/bin/bash

set -o errexit
set -o nounset

DOCKERFILE_DIR="$(dirname "$0")"
NAME="ghcr.io/seantallen/wsl-environments-arch-antithesis-jan2026"

TODAY=$(date +%Y%m%d)
docker build --pull -t "${NAME}:${TODAY}" -t "${NAME}:latest" \
  "${DOCKERFILE_DIR}"
docker push "${NAME}" --all-tags
