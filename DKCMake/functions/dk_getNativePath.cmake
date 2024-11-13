#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_getNativePath(<input> <output>)
#
#
function(dk_getNativePath input output)
	dk_debugFunc(2)
	
	file(TO_NATIVE_PATH "${input}" native_path)
	dk_debug("Converted ${input} to NATIVE_PATH:${native_path}")
	
	if("${output}" MATCHES "ENV{") 
		set(${output} "${native_path}")				# ENV variable
	else()
		set(${output} "${native_path}" PARENT_SCOPE)	# regular variable
	endif()

#DEBUG
#	dk_printVar(native_path)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_getNativePath("C:/Windows/System32" native_path)
	dk_printVar(native_path)
endfunction()