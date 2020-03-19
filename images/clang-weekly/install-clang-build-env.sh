#!/usr/bin/env bash

set -x
set -e

apt-get update

apt-get install -y --no-install-recommends \
      ca-certificates \
      gnupg \
      build-essential \
      wget \
      unzip \
      curl \
      git \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      bison \
      binutils-dev \
      cmake \
      ninja-build \
      python \
      apt-transport-https


rm -rf /var/lib/apt/lists/*

echo "done"
