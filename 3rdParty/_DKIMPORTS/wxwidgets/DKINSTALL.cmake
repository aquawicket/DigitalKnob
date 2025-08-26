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


# https://github.com/wxWidgets/wxWidgets.git



dk_import(https://github.com/wxWidgets/wxWidgets/archive/refs/heads/master.zip)



### LINK ###
dk_include			(${WXWIDGETS}/include)
Unix_dk_libDebug	(${WXWIDGETS_Debug_Dir}/libwxwidgets.a)
Unix_dk_libRelease	(${WXWIDGETS_Release_Dir}/libwxwidgets.a)
Windows_dk_libDebug		(${WXWIDGETS_Debug_Dir}/wxwidgets.lib)
Windows_dk_libRelease	(${WXWIDGETS_Release_Dir}/wxwidgets.lib)


### GENERATE ###
dk_configure(${WXWIDGETS})


### COMPILE ###
dk_build()