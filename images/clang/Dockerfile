#===----------------------------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===----------------------------------------------------------------------===//

# Build GCC versions
FROM debian:stretch AS builder
LABEL maintainer "Eric Fiselier"

ARG cache_date=none

ADD install-clang-build-env.sh /tmp/
RUN /tmp/install-clang-build-env.sh && rm /tmp/install-clang-build-env.sh

ARG VERSION=11
ADD install-clang-packages.sh /tmp/
RUN /tmp/install-clang-packages.sh --version ${VERSION} && rm /tmp/install-clang-packages.sh

ARG branch

ARG CC=clang
ARG CXX=clang++

ENV CC $CC
ENV CXX $CXX

ADD build-llvm-version.sh /tmp/
RUN /tmp/build-llvm-version.sh --install "/compiler" --branch "$branch" \
  && rm /tmp/build-llvm-version.sh


FROM debian:stretch AS compiler-image
COPY --from=builder /compiler /compiler
