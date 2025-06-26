#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_make(Source_Dir, Target)
#
#	@Source_Dir
#	@Target (optional)
#
function(dk_make)
	dk_debugFunc()
	
	###### CURRENT_PLUGIN ######
	dk_assertPath(${CURRENT_PLUGIN})
	
	###### Source_Dir ######
	if(ARGV)
		set(Source_Dir "${ARGV0}")
	else()
		set(Source_Dir "${${CURRENT_PLUGIN}}")
	endif()
	dk_assertPath(Source_Dir)
	
	###### Target ######
	if(ARGV)
		set(Target "${ARGV1}")
	else()
	
	dk_depend(make)
	dk_assertPath(CMAKE_MAKE_PROGRAM)
	
	# https://github.com/emscripten-core/emscripten/issues/2005#issuecomment-32162107
	if(Emscripten)
		dk_fatal("No proper dk_make() implemented for Emscripten" NO_HALT)
		dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
		dk_chdir(${Source_Dir}/${Target_Config})
		
		if(${ARGC} GREATER 1)
			dk_exec(${EMMAKE} ${CMAKE_MAKE_PROGRAM} ${Target} ECHO_OUTPUT_VARIABLE)
		else()
			dk_exec(${EMMAKE} ${CMAKE_MAKE_PROGRAM} ECHO_OUTPUT_VARIABLE)
		endif()
		
		#DEBUG_dk_exec(${CMAKE_COMMAND} --build . --config Debug)
		#RELEASE_dk_exec(${CMAKE_COMMAND} --build . --config Release)

	else()
		if(XCODE)
			if(${ARGC} GREATER 1)
				dk_exec(make ${Target} ECHO_OUTPUT_VARIABLE)
			else()
				dk_exec(make ECHO_OUTPUT_VARIABLE)
			endif()
		else()
			if(${ARGC} GREATER 1)
				if(EXISTS ${PWD}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} ${Target} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${Source_Dir}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} -C ${Source_Dir} ${Target} ECHO_OUTPUT_VARIABLE)
				else()
					dk_error("Could not locate a Makefile")
				endif()
			else()
				if(EXISTS ${PWD}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${Source_Dir}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} -C ${Source_Dir} ECHO_OUTPUT_VARIABLE)
				else()
					dk_error("Could not locate a Makefile")
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