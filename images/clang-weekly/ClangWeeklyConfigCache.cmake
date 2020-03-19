
set(CMAKE_C_COMPILER "clang" CACHE STRING "")
set(CMAKE_CXX_COMPILER "clang++" CACHE STRING "")
set(CMAKE_INSTALL_PREFIX "/compiler" CACHE PATH "")
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
set(LLVM_ENABLE_PROJECTS "clang;compiler-rt;libcxx;libcxxabi;libunwind" CACHE STRING "")
set(LLVM_ENABLE_ASSERTIONS "ON" CACHE BOOL "")
set(LLVM_ENABLE_WARNINGS "OFF" CACHE BOOL "")
set(LLVM_INSTALL_TOOLCHAIN_ONLY "ON" CACHE BOOL "")

