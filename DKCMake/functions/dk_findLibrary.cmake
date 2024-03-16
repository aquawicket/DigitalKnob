include_guard()

###############################################################################
# dk_findLibrary(name) NOASSERT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOASSERT ${ARGV})
	
	find_library(${name}_LIBRARY ${name} ${ARGN})
	if(NOT WIN)
		if(NOT ${name}_LIBRARY)
				dk_error("Could not locate ${name} Library" ${NOASSERT})
				if(NOASSERT)
					set(${name}_LIBRARY ${name})
				endif()
		endif()
		dk_lib(${${name}_LIBRARY})
	else()
		#FIXME: no error control for windows library search
		dk_lib(${name})
	endif()
endfunction()
dk_createOsMacros("dk_findLibrary")
