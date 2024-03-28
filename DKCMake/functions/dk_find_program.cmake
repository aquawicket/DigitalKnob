include_guard()

###############################################################################
# dk_find_program (<VAR> name [path1 path2 ...])
#
#	TODO
#
#	@filename	- TODO
#	@OUTPUT		- TODO
#
function(dk_find_program VAR name)
	dk_debug("dk_find_program(${ARGV})")
	if(${VAR})
		dk_error("error {VAR} already set to ${VAR}")
	endif()
	
	if(ARGN)
		find_program(${VAR} "${name}" ${ARGN} NO_DEFAULT_PATH)
	else()
		find_program(${VAR} "${name}")
	endif()
	dk_debug(VAR PRINTVAR)
	
	
	if(VAR)
		dk_debug("FOUND ${name} at ${${VAR}}")
	else()
		if(DEFINED ${VAR})
			dk_error("COULD NOT FIND ${name}")
		endif()
		dk_notice("COULD NOT FIND ${name}")
	endif()
	set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()