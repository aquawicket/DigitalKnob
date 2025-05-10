#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ cmd ############
#dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd

if(EXISTS "${CMD_EXE}")
	dk_return()
endif()

### Windows Host Only ###
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT WIN_HOST)
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
