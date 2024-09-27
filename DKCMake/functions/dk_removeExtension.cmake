#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_removeExtension(path ret_var) NO_HALT
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@ret_var			- TODO
#   NO_HALT (optional)	- if one of the parameters is NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_removeExtension path ret_var)
	dk_debugFunc("\${ARGV}")
	dk_getOption(NO_HALT ${ARGV})
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
	#dk_includes(${path} "." includes REVERSE)
	#if(NOT includes)
		if(NOT NO_HALT)
			dk_fatal("dk_removeExtension(${path}): no extension found")
		endif()
		return()
	endif()
	
	dk_getExtension("${path}" ext)
	dk_replaceAll("${path}" "${ext}" "" removeExtension)
	#string(SUBSTRING ${path} 0 ${includes} removeExtension)
    set(${ret_var} ${removeExtension} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	set(myPath "C:/Users/yourname/awsomeFile.txt")
	dk_removeExtension("${myPath}" myPath)
	dk_info("${myPath}")
endfunction()