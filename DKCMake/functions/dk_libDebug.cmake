#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_libDebug(lib_path)
#
#	TODO
#
#	@lib_path	- TODO
#	@variable (optional)	- Create a variable to store the lib_path in.
#
function(dk_libDebug lib_path)
	dk_debugFunc("\${ARGV}")
	
	if(NOT DEBUG)
		return()
	endif()	
	
	dk_append(LIBLIST ${lib_path}) # used for double checking
	if(NOT EXISTS ${lib_path})
		dk_echo("${lyellow}MISSING:${yellow} ${lib_path}${clr}")
		dk_set(QUEUE_BUILD ON) 
	endif()
	
	if(lib_path IN_LIST DEBUG_LIBS)
		return() # The library is already in the list
	endif()
	
	if(LINUX OR RASPBERRY OR ANDROID OR EMSCRIPTEN OR MINGW) # FIXME: can this be covered with MULTI_CONFIG and SINGLE_CONFIG ?
		dk_prepend(DEBUG_LIBS debug ${lib_path}) # Add to beginning of list
	else()
		dk_append(DEBUG_LIBS debug ${lib_path}) # Add to end of list
	endif()

	if(INSTALL_DKLIBS)
		if(EXISTS ${lib_path})
			dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
			file(INSTALL ${lib_path} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${LIB_NAME}/${triple}/Debug)
		endif()
	endif()
	
	if(ARGV1)
		dk_set(${ARGV1} ${lib_path}) # add the lib_path to the supplied variable
	endif()
	
endfunction()
dk_createOsMacros("dk_libDebug" "NO_DEBUG_RELEASE_TAGS")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()