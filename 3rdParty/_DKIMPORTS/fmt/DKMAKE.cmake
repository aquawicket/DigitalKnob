#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/fmtlib/fmt
# https://fmt.dev/latest/index.html


### DEPENDS ###
#dk_depend(python3)


### IMPORT ###
#dk_import(https://github.com/fmtlib/fmt.git BRANCH master)# PATCH)
dk_import(https://github.com/fmtlib/fmt/archive/891c9a73ae9a23ed8bffffb8753504b1f6f399d0.zip)
#dk_import(https://github.com/fmtlib/fmt/archive/refs/heads/master.zip)



### INCLUDE/LINK ###
dk_define(FMT_HEADER_ONLY)
dk_include(${FMT_DIR}/include)
###### DEBUG for FMT LIBRARY ######

# moved to DKBuildFlags.cmake
# needed by FMT library
#if(MSVC)
#	dk_append(CMAKE_C_FLAGS /utf-8)
#	dk_append(CMAKE_CXX_FLAGS /utf-8)
#endif()

#UNIX_dk_libDebug	(${FMT_DEBUG_DIR}/libfmtd.a)
#UNIX_dk_libRelease	(${FMT_RELEASE_DIR}/libfmt.a)
#WIN_dk_libDebug	(${FMT_DEBUG_DIR}/fmtd.lib)
#WIN_dk_libRelease	(${FMT_RELEASE_DIR}/fmt.lib)


### GENERATE ###
#dk_configure(${FMT_DIR} -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE)


### COMPILE ###
#dk_build(${FMT_DIR} fmt)
