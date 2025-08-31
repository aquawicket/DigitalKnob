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


############ pugixml ############
# https://github.com/zeux/pugixml

#dk_validate(Target_Config  "dk_Target_Config()")



### IMPORT ###
#dk_import(https://github.com/zeux/pugixml.git)
#dk_import(${pugixml_Import} PATCH)
dk_import()

if(Android)
	dk_define(PUGIXML_NO_EXCEPTIONS)
endif()
