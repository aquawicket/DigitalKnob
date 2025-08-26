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
dk_basename			("${CMAKE_CURRENT_LIST_DIR}" current_plugin)
dk_getFileParams	(${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt)
dk_import			(${${current_plugin}_import} NAME ${current_plugin})

### LINK ###
dk_toUpper("${current_plugin}" CURRENT_PLUGIN)
dk_include			(${${CURRENT_PLUGIN}}/asio/include)
if(MSVC)
	dk_libDebug		(${${CURRENT_PLUGIN}_Debug_Dir}/${current_plugin}.lib)
	dk_libRelease	(${${CURRENT_PLUGIN}_Release_Dir}/${current_plugin}.lib)
else()
	dk_libDebug		(${${CURRENT_PLUGIN}_Debug_Dir}/lib${current_plugin}.a)
	dk_libRelease	(${${CURRENT_PLUGIN}_Release_Dir}/lib${current_plugin}.a)
endif()

dk_configure("${${CURRENT_PLUGIN}}" ${CMAKE_MAKE_PROGRAM} -f "${${CURRENT_PLUGIN}}/asio/src/Makefile.mgw")

dk_build("${${CURRENT_PLUGIN}}")
