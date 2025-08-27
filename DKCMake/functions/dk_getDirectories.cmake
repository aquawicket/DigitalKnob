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
# dk_getDirectories(path rtn_var)
#
#   reference: https://stackoverflow.com/a/138581
#
function(dk_getDirectories)
    dk_debugFunc(1 3)
    
	set(path ${ARGV0})
	
	dk_getParameter(RECURSIVE)
	
	if(RECURSIVE)
		file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	else()
		file(GLOB children LIST_DIRECTORIES true ${path}/*)
	endif()
	foreach(child ${children})
        if(IS_DIRECTORY ${child})
			#dk_echo(${child})
            list(APPEND dk_getDirectories ${child})
        endif()
    endforeach()

	
	###### output ######
	set(dk_getDirectories ${dk_getDirectories} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getDirectories} PARENT_SCOPE)
	else()
		message("${dk_getDirectories}") 
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	
	### Result as global variable
	dk_echo()
	dk_getDirectories("$ENV{DIGITALKNOB_DIR}")
	dk_echo("dk_getDirectories = ${dk_getDirectories}")
	
	### Result as variable parameter
	dk_echo()
	dk_getDirectories("$ENV{DKBRANCH_DIR}" resultB)
	dk_echo("resultB = ${resultB}")
	dk_echo("dk_getDirectories = ${dk_getDirectories}")
	
	### Result as return value			### CMAKE FUNCTIONS DO NOT HAVE RETURN VALUES ###
#	dk_echo()
#	$resultC = dk_getDirectories("$ENV{DKDOWNLOAD_DIR}")
#	dk_echo("resultC = ${resultC}")
#	dk_echo("dk_getDirectories = ${dk_getDirectories}")

	### Result as hashtable parameter
	dk_echo()
	dk_getDirectories("$ENV{DKTOOLS_DIR}" resultD.value)
	dk_echo("resultD.value = ${resultD.value}")
	dk_echo("dk_getDirectories = ${dk_getDirectories}")
endfunction()
    