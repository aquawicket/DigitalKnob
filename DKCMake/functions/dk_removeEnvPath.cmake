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
# dk_removeEnvPath(inputPath)
#
#	@inputPath	- The full path to append to the Environment Path variable
#
function(dk_removeEnvPath)
	dk_debugFunc(1)
   
	set(inputPath "${ARGV0}")
	
	dk_pathToNative("${inputPath}" nativePath)
	if(ENV{PATH} MATCHES "${nativePath}")
		dk_notice("${nativePath} is NOT in the PATH environment list\n")
	else()
		if(WIN32)
			set(PATH "$ENV{PATH}")
			list(REMOVE_ITEM PATH "${nativePath}")
			set(ENV{PATH} "${PATH}")
		else()
			string(REPLACE ":" ";" PATH "$ENV{PATH}")
			list(REMOVE_ITEM PATH "${nativePath}")
			set(ENV{PATH} "${PATH}")
		endif()
		dk_success("removed '${nativePath}' from the PATH environment list\n")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_debug("ENV{PATH} = $ENV{PATH}")
	dk_removeEnvPath("C:/Windows/system32")
	dk_debug("ENV{PATH} = $ENV{PATH}")
endfunction()
