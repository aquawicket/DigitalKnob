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


###### Uninstall keylogger ######
# https://github.com/GiacomoLaw/Keylogger
# https://github.com/GiacomoLaw/Keylogger/archive/142eebd7dee0ac6067642804e80df4b4f375a7bd.zip

### UNINSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/keylogger/dkconfig.txt")
dk_importVariables("${KEYLOGGER_IMPORT}" NAME keylogger)

# TODO - kill keylogger process
dk_delete("${KEYLOGGER}")
