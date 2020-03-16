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
FROM  ericwf/compiler-builder-image AS compiler-zoo
LABEL maintainer "eric@efcs.ca"

# Copy over the GCC and Clang installations
COPY --from=ericwf/compilers-gcc-4.8.5:final /compiler /opt/gcc-4.8.5
COPY --from=ericwf/compilers-gcc-4.9.4:final /compiler /opt/gcc-4.9.4
COPY --from=ericwf/compilers-gcc-5:final /compiler   /opt/gcc-5
COPY --from=ericwf/compilers-gcc-6:final /compiler   /opt/gcc-6
COPY --from=ericwf/compilers-gcc-7:final /compiler   /opt/gcc-7
COPY --from=ericwf/compilers-gcc-8:final /compiler   /opt/gcc-8
COPY --from=ericwf/compilers-gcc-9:final /compiler   /opt/gcc-9
COPY --from=ericwf/compilers-gcc-tot:2020-03-11 /compiler /opt/gcc-tot

COPY --from=ericwf/compilers-llvm-3.6:final /compiler /opt/llvm-3.6
COPY --from=ericwf/compilers-llvm-3.7:final /compiler /opt/llvm-3.7
COPY --from=ericwf/compilers-llvm-3.8:final /compiler /opt/llvm-3.8
COPY --from=ericwf/compilers-llvm-3.9:final /compiler /opt/llvm-3.9
COPY --from=ericwf/compilers-llvm-4:final /compiler /opt/llvm-4
COPY --from=ericwf/compilers-llvm-5:final /compiler /opt/llvm-5
COPY --from=ericwf/compilers-llvm-6:final /compiler /opt/llvm-6
COPY --from=ericwf/compilers-llvm-7:final /compiler /opt/llvm-7
COPY --from=ericwf/compilers-llvm-8:final /compiler /opt/llvm-8
COPY --from=ericwf/compilers-llvm-9:final /compiler /opt/llvm-9
COPY --from=ericwf/compilers-llvm-tot:2020-03-11 /compiler /opt/llvm-tot


