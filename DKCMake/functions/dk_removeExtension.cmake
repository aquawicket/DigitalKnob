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
# dk_removeExtension(path ret_var) NO_HALT
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@ret_var			- TODO
#   NO_HALT (optional)	- if one of the parameters is NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_removeExtension)
	dk_debugFunc()
	
	set(dk_removeExtension ${ARGV0}) # Allow the input variable to pass through in case of failure
	set(path "${ARGV0}")
	dk_getParameter(NO_HALT)
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
		dk_warning("dk_removeExtension(${path}): no extension found")
	else()
		dk_getExtension("${path}")
		dk_replaceAll("${path}" "${dk_getExtension}" "" dk_removeExtension)
		#string(SUBSTRING ${path} 0 ${includes} dk_removeExtension)
	endif()
	
	###### output ######
	set(dk_removeExtension ${dk_removeExtension} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_removeExtension} PARENT_SCOPE)
	else()
		message("${dk_removeExtension}") 
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myPath "C:/Users/yourname/awsomeFile.txt")
	dk_removeExtension("${myPath}")
	dk_echo("dk_removeExtension = ${dk_removeExtension}")
	
	dk_removeExtension("${myPath}" result)
	dk_echo("result = ${result}")
	dk_echo("dk_removeExtension = ${dk_removeExtension}")
	
	set(myPath "?linkid=2289980")
	dk_removeExtension("${myPath}")
	dk_echo("dk_removeExtension = ${dk_removeExtension}")
endfunction()
