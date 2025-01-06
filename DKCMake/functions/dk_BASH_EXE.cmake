#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
	
	###### BASH_EXE ######
	### environment variable bash ###
	if(DEFINED ENV{BASH})
		if(EXISTS "$ENV{BASH}")
			dk_printVar(ENV{BASH})
			if(NOT BASH_EXE)
				dk_set(BASH_EXE "$ENV{BASH}")
				dk_printVar(BASH_EXE)
			endif()
		endif()
	endif()
	
	### Msys2 bash ###
	if(MSYSTEM)
		dk_validate(MSYS2 "dk_depend(msys2)")
		dk_findProgram(MSYS2_BASH_EXE bash "${MSYS2_DIR}/usr/bin")
		if(EXISTS "${MSYS2_BASH_EXE}")
			dk_printVar(MSYS2_BASH_EXE)
			if(NOT BASH_EXE)
				dk_set(BASH_EXE ${MSYS2_BASH_EXE})
				dk_printVar(BASH_EXE)
			endif()
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_BASH_EXE()
    dk_printVar(BASH_EXE)
endfunction()
