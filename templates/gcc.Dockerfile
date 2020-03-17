#===- libcxx/utils/docker/debian9/Dockerfile --------------------------------------------------===//
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===-------------------------------------------------------------------------------------------===//

# Build GCC versions
FROM debian:stretch AS builder

ADD scripts/install-gcc-build-env.sh /tmp/
RUN /tmp/install-gcc-build-env.sh

#===------------------------------------------------------------------------===#
# Configuration
#===------------------------------------------------------------------------===#
ARG branch
ARG cherry_pick

ADD scripts/checkout-gcc.sh /tmp/
RUN /tmp/checkout-gcc.sh \
  --destination /gcc-sources/ \
  --branch "$branch" \
  --cherry-pick "$cherry_pick"

ADD scripts/build-gcc.sh /tmp/
RUN /tmp/build-gcc.sh \
    --source /gcc-sources/ \
    --install "/compiler"

FROM debian:stretch AS compiler-image
COPY --from=builder /compiler/ /compiler/
