#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd

if(EXISTS ${CMD_EXE})
	dk_return()
endif()

### Windows Host Only ###
dk_validate(HOST_TRIPLE "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(cmd)
	dk_return()
endif()



if(WIN_HOST)
	dk_findProgram(CMD_EXE cmd.exe)
	
	if(EXISTS ${CMD_EXE})
		dk_set(CMD_EXE ${CMD_EXE})   # set it globally
		return()
	endif()
endif()



if(NOT EXISTS ${CMD_EXE})
	dk_fatal("Could not file CMD_EXE:${CMD_EXE}")
endif()