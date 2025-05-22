#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_findLibrary(name) NO_HALT
#
#	Search for a library and include it with dk_lib
#
#	@name	- The name of the library
#
function(dk_findLibrary name)
	dk_debugFunc()
	
	dk_getParameter(NO_HALT)
	
	find_library(${name}_LIBRARY ${name} ${ARGN})
	if(NOT Windows)
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
