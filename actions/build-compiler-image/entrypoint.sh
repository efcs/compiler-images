#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
  case "$1" in
    --github-token)
      shift
      GITHUB_TOKEN="$1"
      shift
      ;;
    --image-source)
      shift
      IMAGE_SOURCE="$1"
      shift
      ;;
    --image-name)
      shift
      IMAGE_NAME="$1"
      shift
      ;;
    --image-tag)
      shift
      IMAGE_TAG="$1"
      shift
    -h|--help)
      show_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
  esac
done

echo $GITHUB_REPOSITORY " is the github repo"

docker login -u publisher -p ${GITHUB_TOKEN} docker.pkg.github.com
chmod +x ./images/build-image.sh
./images/build-image.sh --docker-repository docker.pkg.github.com/${GITHUB_REPOSITORY}/${IMAGE_NAME} \
  --docker-tag ${IMAGE_TAG}
  --image ${IMAGE_SOURCE}
docker push
