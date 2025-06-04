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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/triblatron/osgRmlUi


### IMPORT ###
#dk_import(https://github.com/triblatron/osgRmlUi/archive/621fad4fcbdd01306aba3f5c1112c8b03dc8a382.zip)
#dk_import(https://github.com/triblatron/osgRmlUi.git)
dk_import(https://github.com/triblatron/osgRmlUi/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${OSGRMLUI}/include)
dk_include			(${OSGRMLUI}/${Target_Tuple})
Unix_dk_libDebug	(${OSGRMLUI_DEBUG_DIR}/libosgrmlui.a)
Unix_dk_libRelease	(${OSGRMLUI_RELEASE_DIR}/libosgrmlui.a)
Windows_dk_libDebug		(${OSGRMLUI_DEBUG_DIR}/osgrmlui.lib)
Windows_dk_libRelease	(${OSGRMLUI_RELEASE_DIR}/osgrmlui.lib)


### GENERATE ###
dk_configure(${OSGRMLUI})


### COMPILE ###
dk_build(${OSGRMLUI})
