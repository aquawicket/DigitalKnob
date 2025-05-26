#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_BASH_EXE()
#
#
function(dk_BASH_EXE)
	dk_debugFunc()

	if(EXISTS "${BASH_EXE}")
		dk_debug("BASH_EXE:${BASH_EXE} already set")
		return()
	endif()

	### from BASH environment variable ###
	if(NOT EXISTS "${BASH_EXE}")
		dk_set(BASH_EXE "$ENV{BASH}")
	endif()

	### Msys2 bash ###
	if(NOT EXISTS "${BASH_EXE}")
		dk_validate(MSYS2 "dk_depend(msys2)")
		dk_findProgram(MSYS2_BASH_EXE bash "${MSYS2}/usr/bin")
		dk_set(BASH_EXE ${MSYS2_BASH_EXE})
	endif()
	
	if(NOT EXISTS "${BASH_EXE}")
		dk_fatal("BASH_EXE:${BASH_EXE} not found")
		return()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_BASH_EXE()
	dk_printVar(BASH_EXE)
endfunction()
