#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_appendEnvPath(<inputPath>)
#
#	<inputPath>	- The CMake / style full path to append the the Environment Path variable
#
function(dk_appendEnvPath)
	dk_debugFunc(1)
	set(inputPath ${ARGV0})
	
	dk_assertPath(inputPath)

	dk_nativePath("${inputPath}" nativePath)
	
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
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
