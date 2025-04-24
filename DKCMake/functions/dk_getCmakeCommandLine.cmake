#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
	dk_wait()
=======
	dk_timeout()
>>>>>>> Development
	
	set(${rtn_var} "${cmakeCommandLine}" PARENT_SCOPE) #return rtn_var
	#dk_printVar(rtn_var)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()