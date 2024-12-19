#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_prependEnvPath(inputPath)
#
#	@inputPath	- The CMake / style full path to append the the Environment Path variable
#
function(dk_prependEnvPath)
	dk_debugFunc(1)
    dk_assertPath("${ARGV0}")
	set(inputPath "${ARGV0}")
	
	dk_getNativePath("${inputPath}" nativePath)
	if(ENV{PATH} MATCHES "${nativePath}")
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
	dk_debugFunc(0)
	
	dk_prependEnvPath("C:\Windows\System32")
endfunction()
