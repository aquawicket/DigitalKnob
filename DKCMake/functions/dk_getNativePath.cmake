#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_getNativePath(<input> <output>)
#
#
function(dk_getNativePath input output)
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
		
	file(TO_NATIVE_PATH ${input} native_path)
	
	set(${output} ${native_path} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()