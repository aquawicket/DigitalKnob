#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_dirIsEmpty(<path> <rtn_var:optional>)
#
#	Get weather or not a directory is empty
#
#	<path>		- The full path to the directory to check
#	<rtn_var>	- Returns true if the directory is empty. False if the directory is not empty
#
function(dk_dirIsEmpty)
	dk_debugFunc(1 2)
	dk_getArg(0 path)
	dk_getArg(1 rtn_var)
	
	if(EXISTS "${path}")
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(dk_dirIsEmpty false)
		else()
			set(dk_dirIsEmpty true)
		endif()
	else()
		set(dk_dirIsEmpty true)
	endif()

	### return ###
	set(dk_dirIsEmpty ${dk_dirIsEmpty} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_dirIsEmpty} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo("")
	dk_dirIsEmpty("C:/Windows/System32")
	dk_echo("dk_dirIsEmpty = ${dk_dirIsEmpty}")
	
	dk_echo("")
	dk_dirIsEmpty("C:/Windows/System32/drivers" myRtnVar)
	dk_echo("dk_dirIsEmpty = ${dk_dirIsEmpty}")
	dk_echo("myRtnVar = ${myRtnVar}")
endfunction()