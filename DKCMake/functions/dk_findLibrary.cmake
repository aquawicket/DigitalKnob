#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_findLibrary(name) NO_HALT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	dk_debugFunc()
	
<<<<<<< HEAD
	dk_getOption(NO_HALT ${ARGV})
=======
	dk_getOption(NO_HALT)
>>>>>>> Development
	
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
<<<<<<< HEAD
dk_createOsMacros("dk_findLibrary")
=======
>>>>>>> Development






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_findLibrary(todo) # TODO
>>>>>>> Development
endfunction()
