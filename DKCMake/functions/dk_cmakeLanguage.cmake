#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_cmakeLanguage(code)
#
#	polyfill for cmake_language() to call meta-operations on CMake commands.
#
#	@code	- The code to evaluate
#
function(dk_cmakeLanguage code)
	dk_debugFunc("\${ARGV}")
	
	if(${CMAKE_VERSION} GREATER 3.17)
		cmake_language(CALL ${code})
	else()
		dk_fileWrite(${CMAKE_CURRENT_BINARY_DIR}/eval.cmake "${code}")
		include(${CMAKE_CURRENT_BINARY_DIR}/eval.cmake)
		dk_delete(${CMAKE_CURRENT_BINARY_DIR}/eval.cmake)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
