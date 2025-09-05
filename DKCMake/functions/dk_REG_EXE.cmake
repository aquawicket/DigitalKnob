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
# dk_REG_EXE()
#
#
function(dk_REG_EXE)
    dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(REG_EXE "${ARGV0}")
		
	###### GET ######
	elseif(DEFINED ENV{REG_EXE})	
		dk_set(REG_EXE "$ENV{REG_EXE}")
	
	else()
		if(EXISTS "${REG_EXE}")
			dk_debug("REG_EXE:${REG_EXE} already set")
			return()
		endif()
		
		dk_validate(cmd_exe "dk_CMD_EXE()")
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		
		###### CYGPATH_EXE ######
		if(NOT EXISTS "${REG_EXE}")
			set(REG_EXE $ENV{REG_EXE})
		endif()
		if(NOT EXISTS "${REG_EXE}")
			dk_findProgram(REG_EXE reg.exe)
		endif()
	endif()
	
	###### FINALIZE ######
	dk_set(REG_EXE "${REG_EXE}")		# Globalize the variable
	dk_assertPath(REG_EXE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
	dk_echo()
	dk_echo("Test Getting REG_EXE . . .")
    dk_REG_EXE()
	if(EXISTS "${REG_EXE}")
		dk_success("REG_EXE = ${REG_EXE}")
	else()
		dk_error("REG_EXE = ${REG_EXE}")
	endif()
	
	
	dk_echo()
	dk_echo("Test Setting REG_EXE . . .")
    dk_REG_EXE("C:/reg.exe")
	if(EXISTS "${REG_EXE}")
		dk_success("REG_EXE = ${REG_EXE}")
	else()
		dk_error("REG_EXE = ${REG_EXE}")
	endif()
endfunction()
