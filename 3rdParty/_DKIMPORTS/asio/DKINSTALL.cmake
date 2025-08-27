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


################## asio ##################
# https://github.com/chriskohlhoff/asio

dk_depend			(clang)
dk_depend			(make)
dk_basename			("${CMAKE_CURRENT_LIST_DIR}" plugin)
dk_getFileParams	(${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt)
dk_import			(${${Plugin}_import} NAME ${plugin})

### LINK ###
dk_toUpper("${plugin}" PLUGIN)
dk_include			(${${PLUGIN}}/asio/include)
if(MSVC)
	dk_libDebug		(${${PLUGIN}_Debug_Dir}/${plugin}.lib)
	dk_libRelease	(${${PLUGIN}_Release_Dir}/${plugin}.lib)
else()
	dk_libDebug		(${${PLUGIN}_Debug_Dir}/lib${plugin}.a)
	dk_libRelease	(${${PLUGIN}_Release_Dir}/lib${plugin}.a)
endif()

dk_configure("${${PLUGIN}}" ${CMAKE_MAKE_PROGRAM} -f "${${PLUGIN}}/asio/src/Makefile.mgw")

dk_build("${${PLUGIN}}")
