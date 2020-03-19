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

ADD install-clang-build-env.sh /tmp/
RUN /tmp/install-clang-build-env.sh && rm /tmp/install-clang-build-env.sh

#ARG VERSION=11
#ADD install-clang-packages.sh /tmp/
#RUN /tmp/install-clang-packages.sh --version ${VERSION} && rm /tmp/install-clang-packages.sh

RUN apt-get update && apt-get install clang++ -y

ADD ./llvm-project /llvm-project
RUN mkdir /build
ADD ./ClangWeeklyConfigCache.cmake /build/


RUN cd /build && \
    cmake -GNinja \
   -C ClangWeeklyConfigCache.cmake \
    /llvm-project/llvm/

RUN cmake --build /build
RUN cmake --build /build --target install

FROM debian:stretch AS compiler-image
COPY --from=builder /compiler /compiler
