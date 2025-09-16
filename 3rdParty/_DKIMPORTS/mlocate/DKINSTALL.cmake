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
# mlocate
# EXAMPLE Usage:   $ locate libx11.a

if(NOT UNIX_HOST OR Android)
	dk_disable(mlocate)
	dk_return()
endif()

### INSTALL ###
dk_chdir(/usr)
#dk_depend(sudo)
#dk_exec(${sudo_exe} apt -y install mlocate)
dk_installPackage(mlocate)
dk_exec(${sudo_exe} updatedb)
