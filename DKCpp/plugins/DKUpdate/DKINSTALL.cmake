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


############ DKUpdate ############
dk_depend(DKCurl)
dk_depend(DKArchive)

if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
else()
	dk_disable(DKDuktape)
endif()

if(HAVE_DKCef)
	dk_depend(DKCef)
else()
	dk_disable(DKCef)
endif()

############ DKUpdate ############
dk_set(CURRENT_PLUGIN "DKUpdate")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${${CURRENT_PLUGIN}})
dk_build(${${CURRENT_PLUGIN}})
