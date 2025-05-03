#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ asio ############
# https://github.com/chriskohlhoff/asio
#
dk_depend			(clang)
dk_depend			(make)
dk_basename			("${CMAKE_CURRENT_LIST_DIR}" current_plugin)
dk_getFileParams	(${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt)
#dk_importVariables	(${${current_plugin}_import} NAME ${current_plugin})
dk_import			(${${current_plugin}_import} NAME ${current_plugin})



### LINK ###
dk_toUpper("${current_plugin}" CURRENT_PLUGIN)
dk_include			(${${CURRENT_PLUGIN}}/asio/include)
if(MSVC)
	dk_libDebug		(${${CURRENT_PLUGIN}_DEBUG_DIR}/${current_plugin}.lib)
	dk_libRelease	(${${CURRENT_PLUGIN}_RELEASE_DIR}/${current_plugin}.lib)
else()
	dk_libDebug		(${${CURRENT_PLUGIN}_DEBUG_DIR}/lib${current_plugin}.a)
	dk_libRelease	(${${CURRENT_PLUGIN}_RELEASE_DIR}/lib${current_plugin}.a)
endif()


dk_configure("${${CURRENT_PLUGIN}}" ${CMAKE_MAKE_PROGRAM} -f "${${CURRENT_PLUGIN}}/asio/src/Makefile.mgw")


dk_build("${${CURRENT_PLUGIN}}")
