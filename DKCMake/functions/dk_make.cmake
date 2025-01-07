#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_make(path lib)
#
#	TODO
#
#	@path 				- TODO
#	@lib (optional)		- TODO
#
function(dk_make path) #lib
	dk_debugFunc()
	
	dk_assertPath(${path})
	
	dk_depend(make)
	dk_printVar(CMAKE_MAKE_PROGRAM)
	
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
		
		if(XCODE)
			if(${ARGC} GREATER 1)
				dk_queueCommand(make ${lib})
			else()
				dk_queueCommand(make)
			endif()
		else()
			if(${ARGC} GREATER 1)
				if(EXISTS ${PWD}/Makefile)
					dk_queueCommand(${CMAKE_MAKE_PROGRAM} ${lib} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${path}/Makefile)
					dk_queueCommand(${CMAKE_MAKE_PROGRAM} -C ${path} ${lib} ECHO_OUTPUT_VARIABLE)
				else()
					dk_fatal("Could not locate a Makefile")
				endif()
			else()
				if(EXISTS ${PWD}/Makefile)
					dk_queueCommand(${CMAKE_MAKE_PROGRAM} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${path}/Makefile)
					dk_queueCommand(${CMAKE_MAKE_PROGRAM} -C ${path} ECHO_OUTPUT_VARIABLE)
				else()
					dk_fatal("Could not locate a Makefile")
				endif()
			endif()
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_make()
endfunction()