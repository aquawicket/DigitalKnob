include_guard()

###############################################################################
# dk_find_program (<VAR> name1 [path1 path2 ...])
#
#	TODO
#
#	@filename	- TODO
#	@OUTPUT		- TODO
#
function(dk_find_program VAR name1) #[path1 path2 ...])
	find_program(result ${name1} ${ARGN} NO_DEFAULT_PATH)
	if(result)
		dk_debug("FOUND ${name1} = ${result}")
		set(${VAR} ${result} PARENT_SCOPE)
	else()
		if(DEFINED ${VAR})
			dk_error("COULD NOT FIND ${name1}")
		endif()
		dk_notice("COULD NOT FIND ${name1}")
		set(${VAR} ${result} PARENT_SCOPE)
	endif()
endfunction()