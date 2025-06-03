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


############ duk4vb ############
# https://github.com/dzzie/duk4vb.git
# http://sandsprite.com/tools.php?id=23

dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
#dk_import(https://github.com/dzzie/duk4vb.git)
dk_import(http://sandsprite.com/CodeStuff/duk4vb-master.zip)
