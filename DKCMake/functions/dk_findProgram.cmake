#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findProgram (<VAR> filename [path1 path2 ...])
#
#	TODO
#
#	<VAR>				- TODO
#	filename			- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_findProgram VAR filename)
	dk_debugFunc("\${ARGV}")
	#dk_debug("dk_findProgram(${VAR}, ${filename})")
	
	if(EXISTS ${${VAR}})
		dk_debug("already FOUND ${filename} at ${${VAR}}")
		return()
	endif()
	
	if("${${VAR}}" STREQUAL "${VAR}-NOTFOUND")
		set(${VAR}_second_pass 1)
	endif()
	
	if(${VAR})
		dk_fatal("error {VAR} already set to ${VAR}")
	endif()
	
	if(ARGN)
		dk_getDirectories("${ARGN}" SEARCH_DIRS RECURSIVE)
		list(REMOVE_DUPLICATES SEARCH_DIRS)
	endif()
	if(SEARCH_DIRS)
		dk_info("Searching Provided Paths recursivley with NO_DEFAULT_PATH set . . .")
		find_program(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	elseif(ARGN)
		dk_info("Searching Provided Path with NO_DEFAULT_PATH set . . .")
		find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	else()
		dk_info("Searching Default Paths. . .")
		find_program(${VAR} ${filename})
	endif()
	
	if(EXISTS ${${VAR}})
		dk_info("FOUND ${filename} at ${${VAR}}")
		dk_set(${VAR} "${${VAR}}")
		set(${VAR} "${${VAR}}" PARENT_SCOPE)
		return()
	elseif(${VAR}_second_pass)
		dk_fatal("COULD NOT FIND ${filename}")
		return()
	endif()
	
	dk_notice("COULD NOT FIND ${filename}")
	set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()