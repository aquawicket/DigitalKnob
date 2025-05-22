#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_cmakeLanguage(code)
#
#	polyfill for cmake_language() to call meta-operations on CMake commands.
#
#	@code	- The code to evaluate
#
function(dk_cmakeLanguage code)
	dk_debugFunc()
	
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
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
