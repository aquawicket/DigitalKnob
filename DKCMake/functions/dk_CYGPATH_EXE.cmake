#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_CYGPATH_EXE()
#
#
function(dk_CYGPATH_EXE)
    dk_debugFunc()

	if(EXISTS "${CYGPATH_EXE}")
		dk_debug("CYGPATH_EXE:${CYGPATH_EXE} already set")
		return()
	endif()
	
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	
	###### CYGPATH_EXE ######
	if(NOT EXISTS "${CYGPATH_EXE}")
		set(CYGPATH_EXE $ENV{CYGPATH_EXE})
	endif()
	if(NOT EXISTS "${CYGPATH_EXE}")
		execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	if(NOT EXISTS "${CYGPATH_EXE}")
		dk_findProgram(CYGPATH_EXE cygpath.exe ${DKTOOL_DIR})
	endif()
	if(NOT EXISTS "${CYGPATH_EXE}")
		dk_warning("CYGPATH_EXE:${CYGPATH_EXE} not found")
	else()
		dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
		dk_printVar(CYGPATH_EXE)
		set(ENV{CYGPATH_EXE} "${CYGPATH_EXE}")		# Set Environment Varible
		dk_printVar(ENV{CYGPATH_EXE})
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    dk_CYGPATH_EXE()
    dk_printVar(CYGPATH_EXE)
endfunction()
