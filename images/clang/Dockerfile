#===----------------------------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===----------------------------------------------------------------------===//

# Build GCC versions
FROM debian:stretch AS llvm-sources

ARG HOST_CLANG_VERSION=11

RUN echo "Installing packages...." \
  && apt-get update \
  && apt-get install -y --no-install-recommends --fix-missing apt-utils  \
  && apt-get upgrade -y  \
  && apt-get install -y --fix-missing --no-install-recommends \
                apt-utils  \
                apt-transport-https \
                lsb-release \
                ca-certificates \
                wget \
                software-properties-common \
                gnupg

RUN apt-get update --fix-missing \
  &&  apt-get upgrade -y  --fix-missing \
  && apt-get install -y \
           build-essential \
           unzip \
           automake \
           curl \
           git \
           'gcc-multilib' \
           'g++-multilib' \
           libc6-dev \
           bison \
           flex \
           libtool \
           autoconf \
           binutils-dev \
           cmake \
           ninja-build \
           python


RUN wget -O /tmp/llvm.sh https://apt.llvm.org/llvm.sh \
   && chmod +x /tmp/llvm.sh \
   && /tmp/llvm.sh \
   && ln -s $(which clang-${HOST_CLANG_VERSION}) /usr/local/bin/clang \
   && ln -s $(which clang++-${HOST_CLANG_VERSION}) /usr/local/bin/clang++

RUN clang++ --version

ARG CMAKE_VERSION=3.18.2
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh -O /tmp/install.sh \
  && sh  /tmp/install.sh --prefix=/usr/local --exclude-subdir \
  && rm /tmp/install.sh


RUN echo "Checking out full LLVM..." \
    && git clone  https://github.com/llvm/llvm-project.git /llvm-sources \
    && git -C /llvm-sources/ pull --all


FROM llvm-sources AS builder
LABEL maintainer "Eric Fiselier"


ARG cache_date=none
ARG branch

RUN cd /llvm-sources/ \
  && git fetch origin "$branch" \
  && git checkout "$branch" \
  && git pull \
  && rm -rf .git \
  && ln -s $PWD/libcxx $PWD/llvm/projects/libcxx \
  && ln -s $PWD/libcxxabi $PWD/llvm/projects/libcxxabi \
  && ln -s $PWD/compiler-rt $PWD/llvm/projects/compiler-rt \
  && ln -s $PWD/clang $PWD/llvm/tools/clang \
  && ln -s $PWD/clang-tools-extra $PWD/llvm/tools/clang/tools/extra

ARG CC=clang
ARG CXX=clang++

ENV CC $CC
ENV CXX $CXX

RUN mkdir /tmp/llvm-build && cd /tmp/llvm-build \
  && cmake -GNinja \
      -DCMAKE_INSTALL_PREFIX="/compiler" \
      "-DCMAKE_C_COMPILER=$CC" \
      "-DCMAKE_CXX_COMPILER=$CXX" \
      -DCMAKE_BUILD_TYPE=RELEASE \
      "-DCMAKE_CXX_FLAGS=-gline-tables-only" \
      "-DCMAKE_C_FLAGS=-gline-tables-only" \
      -DLLVM_ENABLE_ASSERTIONS=ON \
      -DLLVM_ENABLE_WARNINGS=OFF \
      -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
      /llvm-sources/llvm/

RUN ninja -C /tmp/llvm-build install


FROM debian:stretch AS compiler-image
COPY --from=builder /compiler /compiler
