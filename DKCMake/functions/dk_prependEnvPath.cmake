#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_prependEnvPath(inputPath)
#
#	@inputPath	- The CMake / style full path to append the the Environment Path variable
#
function(dk_prependEnvPath inputPath)
	dk_debugFunc()
	
	#if(NOT inputPath)
	#	dk_fatal("dk_prependEnvPath(): inputPath is invalid!")
	#	dk_return()
	#endif()
    
	#if(NOT EXISTS ${inputPath})
	#	dk_warning("dk_prependEnvPath(): inputPath does not exist")
	#	dk_return()
	#endif()
    
    dk_assertPath(inputPath)
	#if(WIN_HOST)
		cmake_path(NATIVE_PATH inputPath NORMALIZE nativePath)
		dk_debug("Converted ${inputPath} to NATIVE_PATH:${nativePath}")
	#endif()

	string(FIND "$ENV{PATH}" "${nativePath}" hasPath)
	if(${hasPath} GREATER -1)
		dk_notice("${nativePath} is already in the PATH environment list\n")
	else()
		if(WIN_HOST)
			set(ENV{PATH} "${nativePath};$ENV{PATH}")
		else()
			set(ENV{PATH} "${nativePath}:$ENV{PATH}")
		endif()
		dk_success("prepended ${nativePath} to the PATH environment list\n")
		
		dk_exportVars(PATH "$ENV{PATH}")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
