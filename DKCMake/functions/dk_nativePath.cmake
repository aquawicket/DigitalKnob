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
# dk_nativePath(<input> <output>)
#
#
function(dk_nativePath input output)
	dk_debugFunc(2)
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.20")
		cmake_path(NATIVE_PATH input NORMALIZE native_path)
	else()
		file(TO_NATIVE_PATH "${input}" native_path)
	endif()
	dk_debug("Converted ${input} to NATIVE_PATH:${native_path}")
	
	if("${output}" MATCHES "ENV{") 
		set(${output} "${native_path}")					# ENV variable
	else()
		set(${output} "${native_path}" PARENT_SCOPE)	# regular variable
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_nativePath("C:/Windows/System32" native_path)
	dk_printVar(native_path)
endfunction()