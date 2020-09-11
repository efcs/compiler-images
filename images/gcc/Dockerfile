#===- libcxx/utils/docker/debian9/Dockerfile --------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-------------------------------------------------------------------------------------------===//

# Build GCC versions
FROM debian:stretch AS gcc-checkout

RUN mkdir /gcc-source/
RUN git clone git://gcc.gnu.org/git/gcc.git /gcc-sources/
RUN git -C /gcc-sources/ pull --all


FROM debian:stretch AS builder
LABEL maintainer "Eric Fiselier"

COPY --from=gcc-checkout /gcc-sources/ /gcc-sources/

ARG cache_date=none

ADD  install-gcc-build-env.sh /tmp/
RUN /tmp/install-gcc-build-env.sh

#===------------------------------------------------------------------------===#
# Configuration
#===------------------------------------------------------------------------===#
ARG branch
ARG cherry_pick

ADD checkout-gcc.sh /tmp/
RUN /tmp/checkout-gcc.sh \
  --no-checkout \
  --destination /gcc-sources/ \
  --branch "$branch" \
  --cherry-pick "$cherry_pick"

ADD build-gcc.sh /tmp/
RUN /tmp/build-gcc.sh \
    --source /gcc-sources/ \
    --install "/compiler"

FROM debian:stretch AS compiler-image
COPY --from=builder /compiler/ /compiler/
