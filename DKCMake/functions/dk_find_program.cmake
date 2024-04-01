include_guard()

###############################################################################
# dk_find_program (<VAR> name [path1 path2 ...])
#
#	TODO
#
#	<VAR>				- TODO
#	name				- TODO
# 	[path1 path2 ...]	- TODO
#
function(dk_find_program VAR name)
	dk_debug(" ")
	dk_debug("dk_find_program(${ARGV})")
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
		find_program(${VAR} "${name}" ${ARGN} NO_DEFAULT_PATH)
	else()
		find_program(${VAR} "${name}")
	endif()
	
	if(EXISTS ${${VAR}})
		dk_debug("FOUND ${name} at ${${VAR}}")
		dk_set(${VAR} "${${VAR}}")
		return()
	elseif(${VAR}_second_pass)
		dk_error("COULD NOT FIND ${name}")
		return()
	endif()
	
	dk_notice("COULD NOT FIND ${name}")
	set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()