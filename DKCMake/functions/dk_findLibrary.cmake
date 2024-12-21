#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findLibrary(name) NO_HALT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	dk_debugFunc()
	
	dk_getOption(NO_HALT)
	
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






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_findLibrary(todo) # TODO
endfunction()
