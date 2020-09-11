#!/usr/bin/env bash
#===- libcxx/utils/docker/scripts/build-gcc.sh ----------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-----------------------------------------------------------------------===//

set -e

function show_usage() {
  cat << EOF
Usage: build-gcc.sh [options]

Run autoconf with the specified arguments. Used inside docker container.

Available options:
  -h|--help           show this help message
  --source            the directory of the GCC sources
  --install           destination directory where to install the targets.
Required options: --install and --source

EOF
}

GCC_INSTALL_DIR=""
GCC_SOURCE_DIR=""


while [[ $# -gt 0 ]]; do
  case "$1" in
    --install)
      shift
      GCC_INSTALL_DIR="$1"
      shift
      ;;
    --source)
      shift
      GCC_SOURCE_DIR="$1"
      shift
      ;;
    -h|--help)
      show_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
  esac
done

if [ "$GCC_INSTALL_DIR" == "" ]; then
  echo "No install directory. Please specify the --install argument."
  exit 1
fi
if [ "$GCC_SOURCE_DIR" == "" ]; then
  echo "No source directory. Please specify the --source argument."
  exit 1
fi


set -x


NPROC=`nproc`
TMP_ROOT="$(mktemp -d -p /tmp)"
GCC_BUILD_DIR="$TMP_ROOT/build"

pushd "$GCC_SOURCE_DIR"
./contrib/download_prerequisites
popd


mkdir "$GCC_BUILD_DIR"
pushd "$GCC_BUILD_DIR"

# Run the build as specified in the build arguments.
echo "Running configuration"
$GCC_SOURCE_DIR/configure --prefix=$GCC_INSTALL_DIR \
  --disable-bootstrap --disable-libgomp --disable-libitm \
  --disable-libvtv --disable-libcilkrts --disable-libmpx \
  --disable-liboffloadmic --disable-libcc1 --enable-languages=c,c++

echo "Running build with $NPROC threads"
make -j$NPROC
echo "Installing to $GCC_INSTALL_DIR"
make install -j$NPROC
popd

# Cleanup.
rm -rf "$TMP_ROOT"

echo "Done"
