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


############ lunasvg ############
# https://github.com/sammycage/lunasvg.git
# https://github.com/sammycage/lunasvg/archive/refs/heads/master.zip

dk_import()

dk_include			(${lunasvg}/include						LUNASVG_INCLUDE_DIR)

if(MSVC)
	dk_libDebug		(${lunasvg_Debug_Dir}/lunasvg.lib		LUNASVG_LIBRARY_DEBUG)
	dk_libRelease	(${lunasvg_Release_Dir}/liblunasvg.lib	LUNASVG_LIBRARY_RELEASE)
else()
	dk_libDebug		(${lunasvg_Debug_Dir}/liblunasvg.a		LUNASVG_LIBRARY_DEBUG)
	dk_libRelease	(${lunasvg_Release_Dir}/liblunasvg.a	LUNASVG_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
dk_set		(lunasvg_CMAKE -DLUNASVG_DIR=${lunasvg} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})
if(Debug)
	dk_set	(lunasvg_CMAKE -DLUNASVG_DIR=${lunasvg} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_DEBUG} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_DEBUG})
endif()
if(Release)
	dk_set	(lunasvg_CMAKE -DLUNASVG_DIR=${lunasvg} -DLUNASVG_INCLUDE_DIR=${LUNASVG_INCLUDE_DIR} -DLUNASVG_LIBRARY_DEBUG=${LUNASVG_LIBRARY_RELEASE} -DLUNASVG_LIBRARY_RELEASE=${LUNASVG_LIBRARY_RELEASE})
endif()

dk_configure()

dk_build()
