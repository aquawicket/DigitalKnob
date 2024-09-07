include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_prependEnvPath(inputPath)
#
#	@inputPath	- The CMake / style full path to append the the Environment Path variable
#
function(dk_prependEnvPath inputPath)
	dk_debugFunc("\${ARGV}")
	
	if(NOT inputPath)
		dk_fatal("dk_prependEnvPath(): inputPath is invalid!")
		return()
	endif()
	if(NOT EXISTS ${inputPath})
		dk_fatal("dk_prependEnvPath(): inputPath does not exist")
		return()
	endif()
	if(WIN_HOST)
		dk_debug("Converting value to NATIVE_PATH")
		cmake_path(NATIVE_PATH inputPath NORMALIZE nativePath)
	endif()

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
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()