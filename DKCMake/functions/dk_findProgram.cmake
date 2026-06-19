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


#if(NOT DEFINED dk_findProgram_DEBUG)
#	dk_set(dk_findProgram_DEBUG 1)
#endif()
#########################################################################
# dk_findProgram (<VAR> filename [path1 path2 ...])
#
#	TODO
#
#	<VAR>				- TODO
#	filename			- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_findProgram VAR filename)
	dk_debugFunc()
	
	if(EXISTS ${${VAR}})
		if("${dk_findProgram_DEBUG}" STREQUAL "1")
			dk_debug("already FOUND ${filename} at ${${VAR}}")
		endif()
		return()
	endif()
	
	#if("${${VAR}}" STREQUAL "${VAR}-NOTFOUND")
	#	set(${VAR}_second_pass 1)
	#endif()
	
	if(${${VAR}})
		dk_error("error ${VAR} already set to ${${VAR}}")
	endif()
	
	if(ARGN)
		dk_getDirectories("${ARGN}" SEARCH_DIRS RECURSIVE)
		list(REMOVE_DUPLICATES SEARCH_DIRS)
	endif()
	if(SEARCH_DIRS)
#		dk_info("find_program(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)")
		find_program(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH) # NO_CACHE)
	elseif(ARGN)
#		dk_info("find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)")
		find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH) # NO_CACHE)
	else()
#		dk_info("find_program(${VAR} ${filename})")
		find_program(${VAR} ${filename}) # NO_CACHE)
	endif()
	
	if(EXISTS ${${VAR}})
#		dk_info("FOUND ${filename} at ${${VAR}}")
		set(${VAR} "${${VAR}}" PARENT_SCOPE)
#		dk_set(${VAR} "${${VAR}}")
		return()
	#elseif(${VAR}_second_pass)
	#	dk_error("COULD NOT FIND ${filename}")
	#	dk_unset(${VAR})
	#	return()
	endif()
	
	#dk_notice("COULD NOT FIND ${filename}")
	#dk_set(${VAR} "${${VAR}}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_findProgram(python_exe python)
endfunction()