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

##################################################################################
# dk_dirname(path, rtn_var)
#
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@rtn_var	- Returns the directory upon success: False upon error
#
#   Reference	- https://en.wikipedia.org/wiki/Dirname
#
function(dk_dirname)
	dk_debugFunc(1 2)
	dk_getArg(0 path)
	dk_getArg(1 rtn_var)
	
	get_filename_component(fullpath ${path} ABSOLUTE)
	get_filename_component(dk_dirname "${fullpath}" DIRECTORY)
	
	### return ###
	set(dk_dirname "${dk_dirname}" PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} "${dk_dirname}" PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_echo("")
	dk_dirname("C:/Windows/System32")
	dk_echo("dk_dirname = ${dk_dirname}")
	
	dk_echo("")
	dk_dirname("C:/Windows/System32/drivers" myRtnVal)
	dk_echo("dk_dirname = ${dk_dirname}")
	dk_echo("myRtnVal = ${myRtnVal}")
endfunction()