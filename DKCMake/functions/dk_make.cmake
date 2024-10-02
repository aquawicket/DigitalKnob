#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_make(path lib)
#
#	TODO
#
#	@path 				- TODO
#	@lib (optional)		- TODO
#
function(dk_make path) #lib
	dk_debugFunc("\${ARGV}")
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_make(${path}) path does not exist")
	endif()
	
	# https://github.com/emscripten-core/emscripten/issues/2005#issuecomment-32162107
	if(EMSCRIPTEN)
		dk_fatal("No proper dk_make() implemented for emscripten" NO_HALT)
		dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
		dk_cd(${path}/${CONFIG_PATH})
		
		if(${ARGC} GREATER 1)
			dk_queueCommand(${EMMAKE} ${CMAKE_MAKE_PROGRAM} ${lib})
		else()
			dk_queueCommand(${EMMAKE} ${CMAKE_MAKE_PROGRAM})
		endif()
		
		#DEBUG_dk_queueCommand(${CMAKE_COMMAND} --build . --config Debug)
		#RELEASE_dk_queueCommand(${CMAKE_COMMAND} --build . --config Release)
	else()
		set(lib ${ARGV1})
		#dk_cd(${path}/${CONFIG_PATH})
		dk_validate(CMAKE_MAKE_PROGRAM "dk_depend(make)")
		dk_assertVar(CMAKE_MAKE_PROGRAM)
		dk_printVar(CMAKE_MAKE_PROGRAM)
		if(XCODE)
			if(${ARGC} GREATER 1)
				dk_queueCommand(make ${lib})
			else()
				dk_queueCommand(make)
			endif()
		else()
			if(${ARGC} GREATER 1)
				dk_queueCommand(${CMAKE_MAKE_PROGRAM} ${lib}) # BASH_ENV)
			else()
				dk_queueCommand(${CMAKE_MAKE_PROGRAM}) # BASH_ENV)
			endif()
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()