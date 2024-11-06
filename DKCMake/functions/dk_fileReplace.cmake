#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_fileReplace(filePath find replace) NO_HALT
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#   NO_HALT (optional)	- if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_fileReplace filePath find replace)
	dk_debugFunc()
	
	dk_getOption(NO_HALT ${ARGV})
	
	file(READ ${filePath} fileString)
	if(fileString MATCHES "${find}")
		dk_replaceAll("${fileString}"  "${find}"  "${replace}" fileString)
		dk_fileWrite(${filePath} "${fileString}")
	else()
		dk_fatal("cannot find \"${find}\"  in  (${filePath})" ${NO_HALT})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
