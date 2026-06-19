#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libuv ############
# https://github.com/libuv/libuv.git

dk_depend			(iphlpapi)
dk_depend			(userenv)

dk_import			()

dk_include			(${libuv}/include					LIBUV_INCLUDE_DIR)
dk_include			(${libuv}/${Target_Tuple}			LIBUV_INCLUDE_DIR2)
if(MSVC)
	dk_libDebug		(${libuv_Debug_Dir}/uv_a.lib		LIBUV_DEBUG_LIBRARY		LIBUV_LIBRARY)
	dk_libRelease	(${libuv_Release_Dir}/uv_a.lib		LIBUV_RELEASE_LIBRARY	LIBUV_LIBRARY)
else()
	dk_libDebug		(${libuv_Debug_Dir}/libuv_a.a		LIBUV_DEBUG_LIBRARY		LIBUV_LIBRARY)
	dk_libRelease	(${libuv_Release_Dir}/libuv_a.a		LIBUV_RELEASE_LIBRARY	LIBUV_LIBRARY)
endif()

dk_set				(libuv_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV_INCLUDE_DIR} -DLIBUV_LIBRARY=${LIBUV_LIBRARY})

dk_configure		()

dk_build			(${libuv} uv_a)
