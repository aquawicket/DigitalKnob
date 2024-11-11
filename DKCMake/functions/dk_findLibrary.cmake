#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findLibrary(filename [path1 path2 ...]) NO_HALT
#
#	Search for a library and include it with dk_lib
#
#	<VAR>				- TODO
#	filename			- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_findLibrary filename)
	dk_debugFunc()
	
	dk_getOption(NO_HALT ${ARGV})
	
	set(VAR "${filename}_LIBRARY")
	
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
		find_library(${VAR} ${filename} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	elseif(ARGN)
		#dk_info("find_program(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)")
		find_library(${VAR} ${filename} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
	else()
		dk_info("find_program(${VAR} ${filename})")
		find_library(${VAR} ${filename})
	endif()
	
	if(NOT EXISTS ${${VAR}})
		dk_notice("COULD NOT FIND ${filename}")
		dk_unset(${VAR})
		return()
	endif()
	
	dk_success("FOUND ${filename} at ${${VAR}}")
	dk_set(${VAR} "${${VAR}}")
	
	dk_lib(${${VAR}})
	
	
	#find_library(${name}_LIBRARY ${name} ${ARGN})
	#if(NOT WIN)
	#	if(NOT ${name}_LIBRARY)
	#			dk_fatal("Could not locate ${name} Library" ${NO_HALT})
	#			if(NO_HALT)
	#				set(${name}_LIBRARY ${name})
	#			endif()
	#	endif()
	#	dk_lib(${${name}_LIBRARY})
	#else()
	#	dk_lib(${name})
	#endif()
endfunction()
dk_createOsMacros("dk_findLibrary")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_findLibrary(libpdh.a "C:/Users/Administrator/digitalknob/Development/3rdParty/msys2-x86_64-20240727/clang64")
endfunction()
