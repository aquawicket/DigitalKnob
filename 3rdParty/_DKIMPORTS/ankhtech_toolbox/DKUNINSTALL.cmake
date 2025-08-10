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


###### ankhtech_toolbox ######
# https://d9750.download-send.com/d/nryyw7au6cosj4l4onsfta7kzj7jhkkax5a2bclu466wflbbl4u3ovogbyivfspn3iwoq6gn/AT.Toolbox.zip

### UnINSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
set					(ANKHTECH_TOOLBOX "${DKTOOLS_DIR}/Ankhtech_Toolbox")
dk_delete			("${ANKHTECH_TOOLBOX}")

if(NOT EXISTS "${ANKHTECH_TOOLBOX}")
	dk_success("ankhtech_toolbox uninstall complete")
else()
	dk_error("ankhtech_toolbox uninstall failed")
endif()