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


############ cmd ############
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd

if(EXISTS "${cmd_exe}")
	dk_debug("cmd_exe:${cmd_exe} already located")
	return()
endif()


### Windows Host Only ###
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(cmd)
	dk_return()
endif()


if(NOT EXISTS "${cmd_exe}")
	set(cmd_exe "$ENV{ComSpec}")
	string(REPLACE "\\" "/" cmd_exe "${cmd_exe}")
	dk_debug("ComSpec: cmd_exe = ${cmd_exe}")
endif()

if(NOT EXISTS "${cmd_exe}")
	dk_findProgram(cmd_exe cmd.exe)
	string(REPLACE "\\" "/" cmd_exe "${cmd_exe}")
	dk_debug("dk_findProgram: cmd_exe = ${cmd_exe}")
endif()

if(NOT EXISTS "${cmd_exe}")
	dk_fatal("Could not file cmd_exe:${cmd_exe}")
endif()

string(REPLACE "\\" "/" cmd_exe "${cmd_exe}")
dk_set(cmd_exe "${cmd_exe}")  # make variable global
