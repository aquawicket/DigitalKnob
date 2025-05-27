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


############ termux-api ############
# https://github.com/termux/termux-api.git
# https://aktermux.in/adb-in-termux/#howto-step-1680021612068
# https://github.com/termux/termux-api/releases/download/v0.50.1/termux-api_v0.50.1+github-debug.apk
dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

if(NOT Android_Host)
	return()
endif()

#dk_import(https://github.com/termux/termux-api.git)
dk_import(https://github.com/termux/termux-api/archive/refs/heads/master.zip)
