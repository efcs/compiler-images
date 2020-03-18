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
      automake \
      curl \
      git \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      bison \
      flex \
      libtool \
      autoconf \
      binutils-dev \
      software-properties-common

rm -rf /var/lib/apt/lists/*

echo "done"
