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
# dk_basename(<path>, <rtn_var:optional>)
#
#
function(dk_basename)
	dk_debugFunc(1 2)

	###### input ######
	set(path ${ARGV0})
	set(rtn_var ${ARGV1})
	#dk_getArg(0 path)
	#dk_getArg(1 rtn_var)


	get_filename_component(fullpath ${path} ABSOLUTE)
	get_filename_component(dk_basename ${fullpath} NAME)
	
	
	###### output ######
	set(dk_basename ${dk_basename} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_basename} PARENT_SCOPE)
	else()
		message("${dk_basename}") 
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	### Result as global variable
	dk_echo()
	dk_basename("A:/directoryA/filenameA.extA")
	dk_echo("dk_basename = ${dk_basename}")
	
	### Result as variable parameter
	dk_echo()
	dk_basename("B:/directoryB/filenameB.extB" resultB)
	dk_echo("resultB = ${resultB}")
	dk_echo("dk_basename = ${dk_basename}")
	
	### Result as hashtable parameter
	dk_echo()
	dk_basename("C:/directoryC/filenameC.extC" resultC.data)
	dk_echo("resultC.data = $($resultC.data)")
	dk_echo("dk_basename = ${dk_basename}")
	
	### Result as return value
#	dk_echo()
#	$resultD = dk_basename("D:/directoryD/filenameD.extD")
#	dk_echo("resultD = ${resultD}")
#	dk_echo("dk_basename = ${dk_basename}")
endfunction()