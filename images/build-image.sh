#!/usr/bin/env bash

IMAGES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_ROOT="$( realpath $IMAGES_DIR/../)"

set -e

IMAGE_SOURCE=""
DOCKER_REPOSITORY=""
DOCKER_TAG=""

function show_usage() {
  cat << EOF
Usage: build-image.sh [options]

Available options:
  General:
    -h|--help               show this help message
  Docker-specific:
    -s|--image             image source dir (i.e. debian8, nvidia-cuda, etc)
    -d|--docker-repository  docker repository for the image
    -t|--docker-tag         docker tag for the image

Required options: --image and --docker-repository

EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_usage
      exit 0
      ;;
    -i|--image)
      shift
      IMAGE_SOURCE="$1"
      shift
      ;;
    -d|--docker-repository)
      shift
      DOCKER_REPOSITORY="$1"
      shift
      ;;
    -t|--docker-tag)
      shift
      DOCKER_TAG="$1"
      shift
      ;;
    -p|--publish)
      shift
      PUBLISH=""
      ;;

    *)
      echo "Unknown argument $1"
      exit 1
      ;;
  esac
done


command -v docker >/dev/null ||
  {
    echo "Docker binary cannot be found. Please install Docker to use this script."
    exit 1
  }

if [ "$IMAGE_SOURCE" == "" ]; then
  echo "Required argument missing: --source"
  exit 1
fi

if [ "$DOCKER_REPOSITORY" == "" ]; then
  echo "Required argument missing: --docker-repository"
  exit 1
fi

IMAGES_DIR=$(dirname $0)
if [ ! -d "$IMAGES_DIR/$IMAGE_SOURCE" ]; then
  echo "No sources for '$IMAGE_SOURCE' were found in $IMAGES_DIR"
  exit 1
fi

BUILD_DIR=$(mktemp -d)
trap "rm -rf $BUILD_DIR" EXIT
echo "Using a temporary directory for the build: $BUILD_DIR"

cp -r "$IMAGES_DIR/$IMAGE_SOURCE" "$BUILD_DIR/$IMAGE_SOURCE"
cp -r "$REPO_ROOT/scripts" "$BUILD_DIR/scripts"



if [ "$DOCKER_TAG" != "" ]; then
  DOCKER_TAG=":$DOCKER_TAG"
fi

echo "Building ${DOCKER_REPOSITORY}${DOCKER_TAG} from $IMAGE_SOURCE"
sudo docker build \
  -v /var/run/docker.sock:/var/run/docker.sock --privileged \
   -t "${DOCKER_REPOSITORY}${DOCKER_TAG}" \
  -f "$BUILD_DIR/$IMAGE_SOURCE/Dockerfile" \
  "$BUILD_DIR"


echo "Done"
