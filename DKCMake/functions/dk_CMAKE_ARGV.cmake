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
# dk_CMAKE_ARGV()
#	
#	TODO
#
#
function(dk_CMAKE_ARGV)
	dk_debugFunc(0)
	
	if(NOT CMAKE_ARGC)
		dk_info("CMAKE_ARG variables are only set in cmake script mode")
		return()
	endif()
	
	###### CMAKE_ARGV - cmake command line args ######
	unset(CMAKE_ARGV)
	math(EXPR CMAKE_ARGC_END "${CMAKE_ARGC}-1")
	foreach(n RANGE ${CMAKE_ARGC_END})
		list(APPEND CMAKE_ARGV ${CMAKE_ARGV${n}})
	endforeach()
	
	set(CMAKE_ARGV ${CMAKE_ARGV} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_debug("CMAKE_ARGC = ${CMAKE_ARGC}")
	
	math(EXPR END "${CMAKE_ARGC}-1") 
	foreach(N RANGE ${END})
		dk_debug("CMAKE_ARGV${N} = ${CMAKE_ARGV${N}}")
	endforeach()
	
	dk_CMAKE_ARGV()
	dk_debug("CMAKE_ARGV = ${CMAKE_ARGV}")
endfunction()