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
# dk_CMD_EXE()
#
#
function(dk_CMD_EXE)
	dk_fatal("dk_CMD_EXE is deprecated.  Use dk_depend(cmd)")
	if(NOT EXISTS "${cmd_exe}")
		dk_depend(cmd)
	endif()
	return()
	
#########################################
	dk_debugFunc()
	###### SET ######
	if(ARGV)
		dk_set(cmd_exe "${ARGV0}")
		
	###### GET ######
	elseif(cmd_exe)	
		#dk_set(cmd_exe "$ENV{cmd_exe}")
	
	else()
		if(EXISTS "${cmd_exe}")
			dk_debug("cmd_exe:${cmd_exe} already set")
			return()
		endif()
		
		### from cmd_exe environment variable ###
		if(NOT EXISTS "${cmd_exe}")
			dk_set(cmd_exe "$ENV{cmd_exe}")
		endif()
		
		### from COMSPEC environment variable ###
		if(NOT EXISTS "${cmd_exe}")
			dk_set(cmd_exe "$ENV{ComSpec}")
		endif()
		
		### from dk_findProgram ###
		if(NOT EXISTS "${cmd_exe}")
			dk_findProgram(cmd_exe "cmd.exe")
		endif()
		
		### from raw Unix path
		if(NOT EXISTS "${cmd_exe}")
			dk_set(cmd_exe "/c/Windows/System32/cmd.exe")
		endif()
		
		### from raw Wsl path
		if(NOT EXISTS "${cmd_exe}")
			dk_set(cmd_exe "/mnt/c/Windows/System32/cmd.exe")
		endif()
	endif()
	
	###### FINALIZE ######
	dk_assertPath(cmd_exe)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_CMD_EXE()
	if(EXISTS ${cmd_exe})
		dk_success("cmd_exe = ${cmd_exe}")
	else()
		dk_error("cmd_exe = ${cmd_exe}")
	endif()
endfunction()
