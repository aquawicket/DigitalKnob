include_guard()

###############################################################################
# dk_removeExtension(path RESULT) NOERROR
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@RESULT				- TODO
#   NOERROR (optional)	- if one of the parameters is NOERROR, dk_error() messages will not be displayed
#
function(dk_removeExtension path RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOERROR ${ARGV})
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
	#dk_includes(${path} "." includes REVERSE)
	#if(NOT includes)
		if(NOT NOERROR)
			dk_error("no extension found")
		endif()
		return()
	endif()
	
	dk_getExtension(${path} ext)
	string(REPLACE ${ext} "" fileNameNoExt ${path}) 
	#string(SUBSTRING ${path} 0 ${includes} fileNameNoExt)
    set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()