#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


#dk_load(dk_builder)

if(EXISTS ${POWERSHELL_EXE})
	return()
endif()

# try pwsh.exe
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_findProgram(POWERSHELL_EXE "pwsh.exe" "$ENV{DKTOOLS_DIR}")
if(EXISTS ${POWERSHELL_EXE})
	return()
endif()
    
# try powershell.exe
dk_findProgram(POWERSHELL_EXE "powershell.exe")
if(EXISTS ${POWERSHELL_EXE})
	return()
endif()

if(NOT EXISTS ${POWERSHELL_EXE})
	dk_fatal("POWERSHELL_EXE:${POWERSHELL_EXE} not found")
endif()