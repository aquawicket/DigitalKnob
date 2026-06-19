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


################## asio ##################
# https://github.com/chriskohlhoff/asio

dk_depend(clang)
dk_depend(make)


dk_import()

### LINK ###
dk_include			(${${CURRENT_PLUGIN}}/asio/include)
if(MSVC)
	dk_libDebug		(${${CURRENT_PLUGIN}_Debug_Dir}/${CURRENT_PLUGIN}.lib)
	dk_libRelease	(${${CURRENT_PLUGIN}_Release_Dir}/${CURRENT_PLUGIN}.lib)
else()
	dk_libDebug		(${${CURRENT_PLUGIN}_Debug_Dir}/lib${CURRENT_PLUGIN}.a)
	dk_libRelease	(${${CURRENT_PLUGIN}_Release_Dir}/lib${CURRENT_PLUGIN}.a)
endif()

dk_configure("${${CURRENT_PLUGIN}}" ${CMAKE_MAKE_PROGRAM} -f "${${CURRENT_PLUGIN}}/asio/src/Makefile.mgw")

dk_build()
