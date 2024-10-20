#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libuv ############
# https://github.com/libuv/libuv.git

dk_load				(dk_builder)

### DEPEND ###
dk_depend			(iphlpapi)
dk_depend			(userenv)

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam 	("${DKIMPORTS_DIR}/libuv/libuv.txt" LIBUV_DL)
dk_import			(${LIBUV_DL})

### LINK ###
dk_include			(${LIBUV}/include					LIBUV_INCLUDE_DIR)
dk_include			(${LIBUV}/${triple})
if(MSVC)
	dk_libDebug		(${LIBUV_DEBUG_DIR}/uv_a.lib		LIBUV_DEBUG_LIBRARY)
	dk_libRelease	(${LIBUV_RELEASE_DIR}/uv_a.lib		LIBUV_RELEASE_LIBRARY)
else()
	dk_libDebug		(${LIBUV_DEBUG_DIR}/libuv_a.a		LIBUV_DEBUG_LIBRARY)
	dk_libRelease	(${LIBUV_RELEASE_DIR}/libuv_a.a		LIBUV_RELEASE_LIBRARY)
endif()
if(DEBUG)
	set				(LIBUV_LIBRARY ${LIBUV_DEBUG_LIBRARY})
endif()
if(RELEASE)
	set				(LIBUV_LIBRARY ${LIBUV_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
dk_set				(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV_INCLUDE_DIR} -DLIBUV_LIBRARY=${LIBUV_LIBRARY})

### GENERATE ###
dk_configure		(${LIBUV})

### COMPILE ###
dk_build			(${LIBUV} uv_a)
