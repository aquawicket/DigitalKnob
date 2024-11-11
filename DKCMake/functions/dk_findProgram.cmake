#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findProgram (<VAR> filename [path1 path2 ...]) NO_HALT
#
#	Search for a program and return it's path
#
#	<VAR>				- TODO
#	filename			- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_findProgram VAR filename)
	dk_debugFunc()
	
	dk_getOption(NO_HALT ${ARGV})
	
	if(EXISTS ${${VAR}})
		dk_debug("already FOUND ${filename} at ${${VAR}}")
		return()
	endif()
	
	#if("${${VAR}}" STREQUAL "${VAR}-NOTFOUND")
	#	set(${VAR}_second_pass 1)
	#endif()
	
	if(${VAR})
		dk_fatal("error {VAR} already set to ${VAR}" ${NO_HALT})
	endif()
	
	if(ARGN)
		dk_getDirectories("${ARGN}" SEARCH_DIRS RECURSIVE)
		list(REMOVE_DUPLICATES SEARCH_DIRS)
	endif()
	if(SEARCH_DIRS)
		#dk_info("find_program(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)")
		find_program(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	elseif(ARGN)
		#dk_info("find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)")
		find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	else()
		dk_info("find_program(${VAR} ${filename})")
		find_program(${VAR} ${filename})
	endif()
	
	if(NOT EXISTS ${${VAR}})
		dk_notice("COULD NOT FIND ${filename}")
		dk_unset(${VAR})
		return()
	endif()
	
	dk_success("FOUND ${filename} at ${${VAR}}")
	dk_set(${VAR} "${${VAR}}")

endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_findProgram(PYTHON_EXE python)
endfunction()