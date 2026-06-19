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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/kinbei/RmlUiEditor.git


### IMPORT ###
#dk_import(https://github.com/kinbei/RmlUiEditor/archive/3c8b1b239a486ee17401392e1854004b3e3ce6a4.zip)
#dk_import(https://github.com/kinbei/RmlUiEditor.git)
dk_import(https://github.com/kinbei/RmlUiEditor/archive/refs/heads/master.zip)

# TODO
