include_guard()

###############################################################################
# dk_findLibrary(name)
#
#	Search for a library and include it with dk_lib
#
#	@name		- The name of the library
#
function(dk_findLibrary name)
	DKDEBUGFUNC(${ARGV})
	find_library(${name}_LIBRARY ${name})
	if(NOT WIN)
		if(NOT ${name}_LIBRARY)
			dk_error("Could not locate ${name} Library")
		endif()
		dk_debug(${name}_LIBRARY	PRINTVAR)
		dk_lib(${${name}_LIBRARY})
	else()
		dk_debug(name	PRINTVAR)
		dk_lib(${name})
	endif()
endfunction()
#dk_createOsMacros("dk_findLibrary")
