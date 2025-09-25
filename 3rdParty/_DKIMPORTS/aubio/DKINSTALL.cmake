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


############### aubio ###############
# https://github.com/aubio/aubio.git
# https://github.com/aubio/aubio/archive/152d6819b360c2e7b379ee3f373d444ab3df0895.zip

#dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate		(Target_Config  "dk_Target_Config()")
#dk_import			(${aubio_Import})
dk_import()

dk_include			(${aubio}/src)
if(Windows AND MSVC)
	dk_libDebug		(${aubio_Debug_Dir}/aubio.lib)
	dk_libRelease	(${aubio_Release_Dir}/aubio.lib)
else()
	dk_libDebug		(${aubio_Debug_Dir}/libaubio.a)
	dk_libRelease	(${aubio_Release_Dir}/libaubio.a)
endif()

#dk_configure		(${aubio})
dk_build			(${aubio})
