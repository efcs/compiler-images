#===- libcxx/utils/docker/debian9/Dockerfile --------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-------------------------------------------------------------------------------------------===//

# Build GCC versions
FROM debian:stretch AS gcc-checkout

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
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
      && rm -rf /var/lib/apt/lists/*

RUN git clone git://gcc.gnu.org/git/gcc.git /gcc-sources/ \
    && git -C /gcc-sources/ pull --all


FROM gcc-checkout AS builder
LABEL maintainer "Eric Fiselier"

ARG cache_date=none


#===------------------------------------------------------------------------===#
# Configuration
#===------------------------------------------------------------------------===#
ARG branch
ARG cherry_pick

RUN cd /gcc-sources/ \
    && git fetch origin "$branch" \
    && git checkout "$branch" \
    && \
    if [ "$cherry_pick" != "" ]; then \
      git cherry-pick --no-commit -X theirs "$cherry_pick"; \
    fi; \
    rm -rf .git/

ADD build-gcc.sh /tmp/
RUN /tmp/build-gcc.sh \
    --source /gcc-sources/ \
    --install "/compiler" \
    && rm /tmp/build-gcc.sh

FROM debian:stretch AS compiler-image
COPY --from=builder /compiler/ /compiler/
