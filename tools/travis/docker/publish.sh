#!/bin/bash
set -eux

# Build script for Travis-CI.

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../.."


IMAGE_NAME="wskdeploy"
IMAGE_PREFIX=$1
IMAGE_TAG=$2

cp $TRAVIS_BUILD_DIR/build/linux/amd64/wskdeploy $SCRIPTDIR/

cd $SCRIPTDIR

docker build . -t $IMAGE_PREFIX/$IMAGE_NAME:$IMAGE_TAG

if [[ ! -z ${DOCKER_USER} ]] && [[ ! -z ${DOCKER_PASSWORD} ]]; then
docker login -u "${DOCKER_USER}" -p "${DOCKER_PASSWORD}"
fi

docker push $IMAGE_PREFIX/$IMAGE_NAME:$IMAGE_TAG