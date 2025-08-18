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
# dk_basename(_path, _rtn_var)
#
#	Strip directory and suffix from filenames
#
#	Reference: 
#
function(dk_basename)
	dk_debugFunc(1 2)

	###### input ######
	# ARGV0 = _path						#set(_path ${ARGV0})	#dk_getArg(0 _path)
	# ARGV1 = _rtn_var (optional)		#set(_rtn_var ${ARGV1})	#dk_getArg(1 _rtn_var)

	
	get_filename_component(absolute ${ARGV0} ABSOLUTE)
	get_filename_component(dk_basename ${absolute} NAME)
	
	
	###### output ######
	set(dk_basename ${dk_basename} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_basename} PARENT_SCOPE)
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
	
	### Result as return value			### CMAKE FUNCTIONS DO NOT HAVE RETURN VALUES ###
#	dk_echo()
#	$resultC = dk_basename("C:/directoryC/filenameC.extC")
#	dk_echo("resultC = ${resultC}")
#	dk_echo("dk_basename = ${dk_basename}")

	### Result as hashtable parameter
	dk_echo()
	dk_basename("D:/directoryD/filenameD.extD" resultD.value)
	dk_echo("resultD.value = ${resultD.value}")
	dk_echo("dk_basename = ${dk_basename}")
endfunction()