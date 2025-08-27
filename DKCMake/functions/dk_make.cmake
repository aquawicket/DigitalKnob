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
#	Run a Makefile for project if it exists in 'Source_Dir"
#
#	@Source_Dir - The location of the Makefile
#	@Target (optional) - The target to build
#
function(dk_make)
	dk_debugFunc(0 2)
	
	###### PLUGIN ######
	dk_assertPath(${PLUGIN})
	dk_basename("${${PLUGIN}}")
	set(Plugin_Name "${dk_basename}")
	
	###### Source_Dir ######
	if(ARGV)
		set(Source_Dir "${ARGV0}")
	else()
		set(Source_Dir "${${PLUGIN}}")
	endif()
	dk_assertPath(${Source_Dir})
	
	###### Target ######
	if(${ARGC} GREATER 1)
		set(Target "${ARGV1}")
	endif()
	
	dk_depend(make)
	dk_assertPath(CMAKE_MAKE_PROGRAM)
	
	# https://github.com/emscripten-core/emscripten/issues/2005#issuecomment-32162107
	if(Emscripten)
		dk_error("No proper dk_make() implemented for Emscripten" NO_HALT)
		dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
		dk_chdir(${Source_Dir}/${Target_Config})
		
		if(Target)
			dk_exec(${EMMAKE} ${CMAKE_MAKE_PROGRAM} ${Target})
		else()
			dk_exec(${EMMAKE} ${CMAKE_MAKE_PROGRAM})
		endif()
		
		#DEBUG_dk_exec(${CMAKE_COMMAND} --build . --config Debug)
		#RELEASE_dk_exec(${CMAKE_COMMAND} --build . --config Release)
	else()
		#dk_chdir(${Source_Dir}/${Target_Config})
		
		if(XCODE)
			if(Target)
				dk_exec(make ${Target})
			else()
				dk_exec(make)
			endif()
		else()
			if(${ARGC} GREATER 1)
				if(EXISTS ${PWD}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} ${Target} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${Source_Dir}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} -C ${Source_Dir} ${Target} ECHO_OUTPUT_VARIABLE)
				else()
					dk_error("Makefile not found")
				endif()
			else()
				if(EXISTS ${PWD}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} ECHO_OUTPUT_VARIABLE) # BASH_ENV)
				elseif(EXISTS ${Source_Dir}/Makefile)
					dk_exec(${CMAKE_MAKE_PROGRAM} -C ${Source_Dir} ECHO_OUTPUT_VARIABLE)
				else()
					dk_error("Makefile not found")
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