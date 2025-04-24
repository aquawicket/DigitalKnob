#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_dirname(path, rtn_var)
#
<<<<<<< HEAD
#    https://en.wikipedia.org/wiki/Dirname
#
function(dk_dirname path rtn_var)
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	
	get_filename_component(dirname "${path}" DIRECTORY)
	#dk_printVar(dirname)
	set(${rtn_var} "${dirname}" PARENT_SCOPE)
	#dk_printVar(rtn_var)
=======
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@rtn_var	- Returns the directory upon success: False upon error
#
#   Reference	- https://en.wikipedia.org/wiki/Dirname
#
function(dk_dirname)
	dk_debugFunc(2)
	set(path ${ARGV0})
	set(rtn_var ${ARGV1})
	
	get_filename_component(dirname "${path}" DIRECTORY)
	set(${rtn_var} "${dirname}" PARENT_SCOPE)
>>>>>>> Development
endfunction()



<<<<<<< HEAD
function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
=======



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_dirname("C:/Windows/System32" dirname)
	dk_info("dirname = ${dirname}")
endfunction()