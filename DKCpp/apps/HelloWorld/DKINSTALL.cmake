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


###### DEFAULT TARGET ######
dk_validate(Host_Os "dk_Host_Os()")
dk_validate(Host_Arch "dk_Host_Arch()")
dk_Target_Os("${Host_Os}")
dk_Target_Arch("${Host_Arch}")
dk_Target_Env ("Clang")
dk_Target_Type("Debug")
dk_Target_Tuple()


### CURRENT_PLUGIN ###
dk_basename("${CMAKE_CURRENT_LIST_DIR}")
dk_set(CURRENT_PLUGIN "${dk_basename}")
dk_set(${CURRENT_PLUGIN} 	${CMAKE_SOURCE_DIR})

dk_copy("${DKCPP_PLUGINS_DIR}/_DKIMPORT/_CMakeLists.txt_" "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt")
dk_configure(${CMAKE_CURRENT_LIST_DIR})

dk_build(${CMAKE_CURRENT_LIST_DIR})
