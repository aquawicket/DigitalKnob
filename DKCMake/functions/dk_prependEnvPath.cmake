#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_prependEnvPath(inputPath)
#
#	@inputPath	- The CMake / style full path to append the the Environment Path variable
#
<<<<<<< HEAD
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

=======
function(dk_prependEnvPath)
	dk_debugFunc(1)
    dk_assertPath("${ARGV0}")
	set(inputPath "${ARGV0}")
	
	dk_nativePath("${inputPath}" nativePath)
>>>>>>> Development
	if(ENV{PATH} MATCHES "${nativePath}")
		dk_notice("${nativePath} is already in the PATH environment list\n")
	else()
		if(WIN_HOST)
			set(ENV{PATH} "${nativePath};$ENV{PATH}")
		else()
			set(ENV{PATH} "${nativePath}:$ENV{PATH}")
		endif()
		dk_success("prepended ${nativePath} to the PATH environment list\n")
<<<<<<< HEAD
		
=======
>>>>>>> Development
		dk_exportVars(PATH "$ENV{PATH}")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_prependEnvPath("C:\Windows\System32")
>>>>>>> Development
endfunction()
