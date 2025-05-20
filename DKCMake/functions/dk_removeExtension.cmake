#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
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
	
	set(path "${ARGV0}")
	dk_getParameter(NO_HALT)
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
		dk_warning("dk_removeExtension(${path}): no extension found")
		dk_return()
	endif()
	
	dk_getExtension("${path}")
	dk_replaceAll("${path}" "${dk_getExtension}" "" dk_removeExtension)
	#string(SUBSTRING ${path} 0 ${includes} dk_removeExtension)
	
	### return ###
    set(dk_removeExtension ${dk_removeExtension} PARENT_SCOPE)
	
	### rtn_var: OPTIONAL ###
	if(ARGV1)
		set(${ARGV1} ${dk_removeExtension} PARENT_SCOPE)
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myPath "C:/Users/yourname/awsomeFile.txt")
	dk_removeExtension("${myPath}")
	dk_info("${dk_removeExtension}")
	
	dk_removeExtension("${myPath}" result)
	dk_info("${result}")
endfunction()
