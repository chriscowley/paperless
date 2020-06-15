#!/bin/bash

TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
SHA=$(git rev-parse --short HEAD)

for docker_arch in amd64 arm32v7 arm64v8; do
  docker build -t docker.io/chriscowley/paperless:${TAG}-${SHA}-${docker_arch} --build-arg ARCH=${docker_arch} .
  docker tag docker.io/chriscowley/paperless:${TAG}-${SHA}-${docker_arch} docker.io/chriscowley/paperless:latest-${docker_arch}
done
sed "s/{tag}/${TAG}-${SHA}/g" manifest.yml.in > manifest.yml
