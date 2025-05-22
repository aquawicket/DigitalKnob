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
# dk_getCmakeCommandLine(rtn_var)
#	
#	TODO
#
#	@rtn_var			- TODO
#
function(dk_getCmakeCommandLine rtn_var)
	dk_debugFunc()
	
	if(NOT CMAKE_ARGC)
		dk_info("dk_getCmakeCommandLine(): CMAKE_ARGC not set")
		dk_info("CMAKE_ARG variables are only set in cmake script mode")
		return()
	endif()
	
	set(cmakeCommandLine "") # it will contain all params string
	set(ARG_NUM 1) # current index, starting with 1 (0 ignored)
	#math(EXPR ARGC_COUNT "${CMAKE_ARGC}")
	set(ARGC_COUNT "${CMAKE_ARGC}")
	
	while(ARG_NUM LESS ARGC_COUNT)	
		set(CURRENT_ARG ${CMAKE_ARGV${ARG_NUM}})					# making current arg named "CMAKE_ARGV" + "CURRENT_INDEX"
		set(cmakeCommandLine ${cmakeCommandLine} ${CURRENT_ARG})  # adding current param to the list
		math(EXPR ARG_NUM "${ARG_NUM}+1") 							# incrementing current index
	endwhile()
	
	dk_debug(cmakeCommandLine)
	dk_timeout()
	
	set(${rtn_var} "${cmakeCommandLine}" PARENT_SCOPE) #return rtn_var
	#dk_printVar(rtn_var)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()