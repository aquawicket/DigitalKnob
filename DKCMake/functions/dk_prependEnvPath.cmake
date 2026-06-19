#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_prependEnvPath(inputPath)
#
#	@inputPath	- The full path to prepend to the Environment Path variable
#
function(dk_prependEnvPath)
	dk_debugFunc(1)
   
	#dk_assertPath("${ARGV0}")
	set(inputPath "${ARGV0}")
	
	dk_pathToNative("${inputPath}" nativePath)
	if(ENV{PATH} MATCHES "${nativePath}")
		dk_notice("${nativePath} is already in the PATH environment list\n")
	else()
		if(WIN32)
			set(ENV{PATH} "${nativePath};$ENV{PATH}")
		else()
			set(ENV{PATH} "${nativePath}:$ENV{PATH}")
		endif()
		dk_success("prepended ${nativePath} to the PATH environment list\n")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_prependEnvPath("C:\Windows\System32")
endfunction()
