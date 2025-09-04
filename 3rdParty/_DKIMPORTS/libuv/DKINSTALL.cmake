#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ libuv ############
# https://github.com/libuv/libuv.git

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend			(iphlpapi)
dk_depend			(userenv)

### IMPORT ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${LIBUV_DL})

### LINK ###
dk_include			(${LIBUV}/include					LIBUV_INCLUDE_DIR)
dk_include			(${LIBUV}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${LIBUV_Debug_Dir}/uv_a.lib		LIBUV_DEBUG_LIBRARY)
	dk_libRelease	(${LIBUV_Release_Dir}/uv_a.lib		LIBUV_RELEASE_LIBRARY)
else()
	dk_libDebug		(${LIBUV_Debug_Dir}/libuv_a.a		LIBUV_DEBUG_LIBRARY)
	dk_libRelease	(${LIBUV_Release_Dir}/libuv_a.a		LIBUV_RELEASE_LIBRARY)
endif()
if(Debug)
	set				(LIBUV_LIBRARY ${LIBUV_DEBUG_LIBRARY})
endif()
if(Release)
	set				(LIBUV_LIBRARY ${LIBUV_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
dk_set				(libuv_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV_INCLUDE_DIR} -DLIBUV_LIBRARY=${LIBUV_LIBRARY})

### GENERATE ###
dk_configure		(${LIBUV})

### COMPILE ###
dk_build			(${LIBUV} uv_a)
