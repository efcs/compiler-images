#===- libcxx/utils/docker/debian9/Dockerfile --------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-------------------------------------------------------------------------------------------===//

# Build GCC versions
FROM marketplace.gcr.io/google/debian9 AS compiler-builder-image

RUN apt-get update && \
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
      software-properties-common \
      && \
  rm -rf /var/lib/apt/lists/*

FROM compiler-builder-image AS builder

ARG branch=releases/gcc-4.8.5
ARG cherry_pick="3a27b4db566c2cde8e043220f3d2c5401159b10e"

ADD scripts/checkout-gcc.sh /tmp/
RUN /tmp/checkout-gcc.sh \
  --destination /gcc-sources/ \
  --branch "$branch" \
  --cherry-pick "$cherry_pick"


ARG install_prefix=/compiler
ADD scripts/build-gcc.sh /tmp/
RUN /tmp/build-gcc.sh \
    --source /gcc-sources/ \
    --install "$install_prefix"

FROM marketplace.gcr.io/google/debian9 as compiler-image
COPY --from=builder /compiler/ /compiler/
