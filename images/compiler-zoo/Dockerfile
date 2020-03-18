#===- libcxx/utils/docker/debian9/Dockerfile --------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-------------------------------------------------------------------------------------------===//

#===-------------------------------------------------------------------------------------------===//
#  compiler-zoo
#===-------------------------------------------------------------------------------------------===//
FROM  debian:stretch AS compiler-zoo
LABEL maintainer "eric@efcs.ca"


RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      gnupg \
      build-essential \
      wget \
      subversion \
      unzip \
      automake \
      python \
      cmake \
      ninja-build \
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
      binutils-gold \
      software-properties-common \
      gnupg \
      apt-transport-https \
      sudo \
      bash-completion \
      vim \
      gnupg-agent \
      fish \
      fish-common \
       && \
  rm -rf /var/lib/apt/lists/*

# Copy over the GCC and Clang installations
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:4.8.5 /compiler/ /opt/gcc-4.8.5
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:4.9.4 /compiler/ /opt/gcc-4.9.4
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:5.5.0 /compiler/ /opt/gcc-5.5.0
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:6.5.0 /compiler/ /opt/gcc-6.5.0
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:7.4.0 /compiler/ /opt/gcc-7.4.0
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:8.2.0 /compiler/ /opt/gcc-8.2.0
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:9.2.0 /compiler/ /opt/gcc-9.2.0
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:3.6.x /compiler/ /opt/llvm-3.6.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:3.7.x /compiler/ /opt/llvm-3.7.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:3.8.x /compiler/ /opt/llvm-3.8.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:3.9.x /compiler/ /opt/llvm-3.9.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:4.x /compiler/ /opt/llvm-4.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:5.x /compiler/ /opt/llvm-5.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:6.x /compiler/ /opt/llvm-6.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:7.x /compiler/ /opt/llvm-7.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:8.x /compiler/ /opt/llvm-8.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:9.x /compiler/ /opt/llvm-9.x
COPY --from=docker.pkg.github.com/efcs/compiler-images/gcc:trunk-2020-03-15 /compiler/ /opt/gcc-tot
COPY --from=docker.pkg.github.com/efcs/compiler-images/llvm:trunk-2020-03-15 /compiler/ /opt/llvm-tot



