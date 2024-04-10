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
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOERROR ${ARGV})
	
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		string(REPLACE "${find}" "${replace}" fileString "${fileString}")
		file(WRITE ${filePath} "${fileString}")
	else()
		if(NOT NOERROR)
			dk_error("cannot find \"${find}\"  in  (${filePath})")
		endif()
	endif()
endfunction()