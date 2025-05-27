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

dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

## DKTestAll is the "include all plugins" app.
## Here we try to include all plugins and 3rd party libraries for all platforms.
## DKTestAll is handy for debugging purposes and adding new libraries and plugins

#dk_enable(HAVE_DK)
#dk_enable(HAVE_DKCef) ##FIXME: Find a way to remove this requirement

dk_dependAll() ## ADD any and all plugins

if(Linux_Host)
	dk_set(EXCLUDE_ASSETS ON) #assets are too large to embed on my old 1gb x86 dell laptop
endif()
