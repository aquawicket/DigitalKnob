#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_appendEnvPath(<inputPath>)
#
#	<inputPath>	- The CMake / style full path to append the the Environment Path variable
#
<<<<<<< HEAD
function(dk_appendEnvPath inputPath)
	dk_debugFunc()
	
	dk_assertPath(inputPath)
	#if(WIN32)
		cmake_path(NATIVE_PATH inputPath NORMALIZE nativePath)
		dk_debug("Converted ${inputPath} to NATIVE_PATH:${nativePath}")
	#endif()
	
=======
function(dk_appendEnvPath)
	dk_debugFunc(1)
	set(inputPath ${ARGV0})

	dk_assertPath(inputPath)
	dk_nativePath("${inputPath}" nativePath)

>>>>>>> Development
	#dk_printVar(ENV{PATH})
	string(FIND "$ENV{PATH}" "${nativePath}" hasPath)
	if(${hasPath} GREATER -1)
	#if(ENV{PATH} MATCHED "${nativePath}")   # UNTESTED
		dk_notice("${nativePath} is already in the PATH environment list\n")
	else()
		if(WIN_HOST)
			set(ENV{PATH} "$ENV{PATH};${nativePath}")
		else()
			set(ENV{PATH} "$ENV{PATH}:${nativePath}")
		endif()
		dk_info("appended \${nativePath} to the PATH environment list\n")
	endif()
<<<<<<< HEAD
	
# DEBUG
#	dk_printVar(ENV{PATH})
=======
>>>>>>> Development
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
=======
	dk_debugFunc(0)

>>>>>>> Development
	dk_todo()
endfunction()
