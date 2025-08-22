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

dk_stacktrace()

############ cmd ############
#dk_validate(Target_Config  "dk_Target_Config()")
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd

if(EXISTS "${CMD_EXE}")
	return()
endif()

### Windows Host Only ###
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(cmd)
	dk_return()
endif()


if(NOT EXISTS "${CMD_EXE}")
	set(CMD_EXE "$ENV{COMSPEC}")
endif()

if(NOT EXISTS "${CMD_EXE}")
	dk_findProgram(CMD_EXE cmd.exe)
endif()

if(NOT EXISTS "${CMD_EXE}")
	dk_fatal("Could not file CMD_EXE:${CMD_EXE}")
endif()

dk_set(CMD_EXE "${CMD_EXE}")  # make variable global
