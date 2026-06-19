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
# dk_dirname(_path, _rtn_var)
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
	
	###### input ######
	# ARGV0 = _path	
	# ARGV1 = _rtn_var (optional)
	
	set(_path "${ARGV0}")
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.4")
		get_filename_component(_path "${_path}" ABSOLUTE)
	endif()
	get_filename_component(dk_dirname "${_path}" DIRECTORY)
	
	
	###### return ######
	set(dk_dirname ${dk_dirname} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_dirname} PARENT_SCOPE)
	else()
		message("${dk_dirname}") 
	endif()

endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	### Result as global variable
	dk_echo()
	dk_dirname("A:/directoryA/filenameA.extA")
	dk_echo("dk_dirname = ${dk_dirname}")
	
	### Result as variable parameter
	dk_echo()
	dk_dirname("B:/directoryB/filenameB.extB" resultB)
	dk_echo("resultB = ${resultB}")
	dk_echo("dk_dirname = ${dk_dirname}")
	
	### Result as return value			### CMAKE FUNCTIONS DO NOT HAVE RETURN VALUES ###
#	dk_echo()
#	$resultC = dk_dirname("C:/directoryC/filenameC.extC")
#	dk_echo("resultC = ${resultC}")
#	dk_echo("dk_dirname = ${dk_dirname}")

	### Result as hashtable parameter
	dk_echo()
	dk_dirname("D:/directoryD/filenameD.extD" resultD.value)
	dk_echo("resultD.value = ${resultD.value}")
	dk_echo("dk_dirname = ${dk_dirname}")
endfunction()