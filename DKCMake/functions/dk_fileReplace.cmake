include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_fileReplace(filePath find replace) NOERROR
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#   NOERROR (optional)	- if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_fileReplace filePath find replace)
	dk_debugFunc(${ARGV})
	
	dk_getOption(NOERROR ${ARGV})
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		dk_replaceAll("${fileString}"  "${find}"  "${replace}" fileString)
		dk_fileWrite(${filePath} "${fileString}")
	else()
		if(NOT NOERROR)
			dk_error("cannot find \"${find}\"  in  (${filePath})")
		endif()
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)