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

####################################################################
# dk_CYGPATH_EXE()
#
#
function(dk_CYGPATH_EXE)
    dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(CYGPATH_EXE "${ARGV0}")
		
	###### GET ######
	elseif(DEFINED ENV{CYGPATH_EXE})	
		dk_set(CYGPATH_EXE "$ENV{CYGPATH_EXE}")
	
	else()
		if(EXISTS "${CYGPATH_EXE}")
			dk_debug("CYGPATH_EXE:${CYGPATH_EXE} already set")
			return()
		endif()
		
		dk_depend(cmd)
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		
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
	endif()
	
	###### FINALIZE ######
	dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
	#dk_assertPath(CYGPATH_EXE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
	dk_echo()
	dk_echo("Test Getting CYGPATH_EXE . . .")
    dk_CYGPATH_EXE()
	if(EXISTS "${CYGPATH_EXE}")
		dk_success("CYGPATH_EXE = ${CYGPATH_EXE}")
	else()
		dk_error("CYGPATH_EXE = ${CYGPATH_EXE}")
	endif()
	
	dk_echo()
	dk_echo("Test Setting CYGPATH_EXE . . .")
    dk_CYGPATH_EXE("C:/cygpath.exe")
	if(EXISTS "${CYGPATH_EXE}")
		dk_success("CYGPATH_EXE = ${CYGPATH_EXE}")
	else()
		dk_error("CYGPATH_EXE = ${CYGPATH_EXE}")
	endif()
endfunction()
