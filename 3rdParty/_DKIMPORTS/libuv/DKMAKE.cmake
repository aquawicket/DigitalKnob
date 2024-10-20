#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://github.com/libuv/libuv.git


### DEPEND ###
dk_depend(iphlpapi)
dk_depend(userenv)


### IMPORT ###
#dk_import(https://github.com/libuv/libuv.git)
#dk_import(https://github.com/libuv/libuv/archive/refs/tags/v1.44.2.zip)
#dk_import(https://github.com/libuv/libuv.git TAG 2bc22c40eb68f3b38d1ae3ea68ef2f180cbe9fef)
dk_import(https://github.com/libuv/libuv/archive/2bc22c40eb68f3b38d1ae3ea68ef2f180cbe9fef.zip)


### LINK ###
dk_include			(${LIBUV}/include)
dk_include			(${LIBUV}/${triple})
UNIX_dk_libDebug	(${LIBUV}/${triple}/${DEBUG_DIR}/libuv_a.a)
UNIX_dk_libRelease	(${LIBUV}/${triple}/${RELEASE_DIR}/libuv_a.a)
WIN_dk_libDebug		(${LIBUV}/${triple}/${DEBUG_DIR}/uv_a.lib)
WIN_dk_libRelease	(${LIBUV}/${triple}/${RELEASE_DIR}/uv_a.lib)


### 3RDPARTY LINK ###
UNIX_DEBUG_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${triple}/${DEBUG_DIR}/uv_a.a)
UNIX_RELEASE_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${triple}/${RELEASE_DIR}/uv_a.a)
WIN_DEBUG_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${triple}/${DEBUG_DIR}/uv_a.lib)
WIN_RELEASE_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${triple}/${RELEASE_DIR}/uv_a.lib)


### GENERATE ###
dk_configure(${LIBUV})


### COMPILE ###
dk_build(${LIBUV} uv_a)
