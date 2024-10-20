#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/fmtlib/fmt.git
# https://fmt.dev/latest/index.html


### DEPENDS ###
#dk_depend(python3)


### IMPORT ###
dk_import(https://github.com/fmtlib/fmt/archive/fade652ade6e9ba4b16e7484cbda5ee4c9178918.zip)
#dk_import(https://github.com/fmtlib/fmt/archive/cacc3108c5b74020dba7bf3c6d3a7e58cdc085b2.zip)	# BROKEN
#dk_import(https://github.com/fmtlib/fmt/archive/refs/heads/master.zip)							# BROKEN



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
