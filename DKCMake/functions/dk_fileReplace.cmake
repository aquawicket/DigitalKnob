include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_fileReplace(filePath find replace) NO_HALT
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#   NO_HALT (optional)	- if any of the parameters equals NO_HALT, dk_error() messages will not be displayed
#
function(dk_fileReplace filePath find replace)
	dk_debugFunc(${ARGV})
	
	dk_getOption(NO_HALT ${ARGV})
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		dk_replaceAll("${fileString}"  "${find}"  "${replace}" fileString)
		dk_fileWrite(${filePath} "${fileString}")
	else()
		if(NOT NO_HALT)
			#dk_error("cannot find \"${find}\"  in  (${filePath})")
		endif()
		dk_warning("cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
