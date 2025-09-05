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
if(NOT Linux AND NOT Raspberry)
	dk_undepend(libxfixes-dev)
	dk_return()
endif()

### INSTALL ###
if(TINYCORE)
	#dk_exec(tce-load -wi libXfixes-dev.tcz)
	dk_installPackage(libXfixes-dev.tcz)
else()
	#dk_depend(sudo)
	#dk_exec(${sudo_exe} apt -y install libxfixes-dev)
	dk_installPackage(libxfixes-dev)
endif()
