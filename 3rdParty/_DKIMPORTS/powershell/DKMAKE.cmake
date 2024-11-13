#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


#dk_load(dk_builder)

if(EXISTS ${POWERSHELL_EXE})
	return()
endif()

# try pwsh.exe
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_findProgram(POWERSHELL_EXE "pwsh.exe" "${DKTOOLS_DIR}")
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