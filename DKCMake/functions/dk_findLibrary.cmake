include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_findLibrary(name) NO_HALT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	dk_debugFunc("\${ARGV}")
	
	dk_getOption(NO_HALT ${ARGV})
	
	find_library(${name}_LIBRARY ${name} ${ARGN})
	if(NOT WIN)
		if(NOT ${name}_LIBRARY)
				dk_fatal("Could not locate ${name} Library" ${NO_HALT})
				if(NO_HALT)
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






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
