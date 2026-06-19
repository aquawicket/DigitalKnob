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


############ termux-app ############
# https://github.com/termux/termux-app.git
# https://www.macrodroidforum.com/index.php?threads/guide-setting-up-and-using-adb-commands-with-termux.5640/
dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Android_Host)
	return()
endif()


#dk_import(https://github.com/termux/termux-app.git)
dk_import(https://github.com/termux/termux-app/archive/refs/heads/master.zip)
