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
Usage: checkout-gcc.sh [options]

Run autoconf with the specified arguments. Used inside docker container.

Available options:
  -h|--help           show this help message
  --destination       the directory to place the source in
  --branch            the branch of gcc you want to build.
  --cherry-pick       a commit hash to apply to the GCC sources.
Required options: --branch

All options after '--' are passed to CMake invocation.
EOF
}

GCC_SOURCE_DIR=""
GCC_BRANCH=""
CHERRY_PICK=""
NO_CHECKOUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --destination)
      shift
      GCC_SOURCE_DIR="$1"
      shift
      ;;
    --branch)
      shift
      GCC_BRANCH="$1"
      shift
      ;;
    --no-checkout)
      shift
      NO_CHECKOUT=1
      ;;
    --cherry-pick)
      shift
      CHERRY_PICK="$1"
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

if [ "$GCC_SOURCE_DIR" == "" ]; then
  echo "No destination directory. Please specify the --destination argument."
  exit 1
fi

if [ "$GCC_BRANCH" == "" ]; then
  echo "No branch specified. Please specify the --branch argument."
  exit 1
fi

set -x


if [ "$NO_CHECKOUT" == "" ]; then
  echo "Cloning source directory for branch $GCC_BRANCH"
  git clone --branch "$GCC_BRANCH" --single-branch --depth=1 git://gcc.gnu.org/git/gcc.git $GCC_SOURCE_DIR
  if [ "$CHERRY_PICK" != "" ]; then
    git -C "$GCC_SOURCE_DIR" fetch origin master --unshallow # Urg, we have to get the entire history. This will take a while.
  fi
else

  git -C "$GCC_SOURCE_DIR" fetch origin "$GCC_BRANCH"
  git -C "$GCC_SOURCE_DIR" checkout origin "$GCC_BRANCH"
fi

if [ "$CHERRY_PICK" != "" ]; then
  git -C "$GCC_SOURCE_DIR" cherry-pick --no-commit -X theirs "$CHERRY_PICK"
fi
popd

# Cleanup.
rm -rf "$GCC_SOURCE_DIR/.git"

echo "Done"
