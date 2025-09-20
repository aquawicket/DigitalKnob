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


if(EXISTS "${pwsh_exe}")
	return()
endif()

### try pwsh.exe ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_findProgram(pwsh_exe "pwsh.exe" "$ENV{DKTOOLS_DIR}")
if(EXISTS "${pwsh_exe}")
	return()
endif()
    
	
### try powershell.exe ###
dk_findProgram(pwsh_exe "pwsh_exe")
if(EXISTS "${pwsh_exe}")
	return()
endif()


dk_fatal("pwsh_exe:${pwsh_exe} not found")