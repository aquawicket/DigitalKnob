include_guard()

###############################################################################
# dk_findProgram (<VAR> name [path1 path2 ...])
#
#	TODO
#
#	<VAR>				- TODO
#	name				- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_findProgram VAR name)
	dk_debugFunc(${ARGV})
	
	if(EXISTS ${${VAR}})
		dk_debug("already FOUND ${name} at ${${VAR}}")
		return()
	endif()
	
	if("${${VAR}}" STREQUAL "${VAR}-NOTFOUND")
		set(${VAR}_second_pass 1)
	endif()
	
	if(${VAR})
		dk_error("error {VAR} already set to ${VAR}")
	endif()
	
	if(ARGN)
		dk_getSubdirectories("${ARGN}" SEARCH_DIRS) # Recursive search
		list(REMOVE_DUPLICATES SEARCH_DIRS)
	endif()
	if(SEARCH_DIRS)
		dk_info("Searching Provided Paths recursivley with NO_DEFAULT_PATH set . . .")
		#dk_debug("find_program(${VAR} ${name} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH)")
		find_program(${VAR} ${name} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH)
	elseif(ARGN)
		dk_info("Searching Provided Path with NO_DEFAULT_PATH set . . .")
		dk_info("find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH)")
		#dk_debug("find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH)")
		find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH)
	else()
		dk_info("Searching Default Paths. . .")
		find_program(${VAR} ${name})
	endif()
	
	if(EXISTS ${${VAR}})
		dk_info("FOUND ${name} at ${${VAR}}")
		dk_set(${VAR} "${${VAR}}")
		set(${VAR} "${${VAR}}" PARENT_SCOPE)
		return()
	elseif(${VAR}_second_pass)
		dk_error("COULD NOT FIND ${name}")
		return()
	endif()
	
	dk_notice("COULD NOT FIND ${name}")
	set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()