
set(CMAKE_C_COMPILER "clang" CACHE "")
set(CMAKE_CXX_COMPILER "clang++" CACHE "")
set(CMAKE_INSTALL_PREFIX "/compiler" CACHE PATH "")
set(CMAKE_BUILD_TYPE "Release" CACHE "")
set(CMAKE_C_COMPILER "clang" CACHE "")
set(LLVM_ENABLE_PROJECTS "clang;compiler-rt;libcxx;libcxxabi;libunwind" CACHE "")
set(LLVM_ENABLE_ASSERTIONS "ON" CACHE "")
set(LLVM_ENABLE_WARNINGS "OFF" CACHE "")
set(LLVM_INSTALL_TOOLCHAIN_ONLY "ON" CACHE "")

