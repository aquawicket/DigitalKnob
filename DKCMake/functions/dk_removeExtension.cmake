include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_removeExtension(path ret_var) NOERROR
#
#	Remove the extension from a file path
#
#	@path				- TODO
#	@ret_var			- TODO
#   NOERROR (optional)	- if one of the parameters is NOERROR, dk_error() messages will not be displayed
#
function(dk_removeExtension path ret_var)
	dk_debugFunc(${ARGV})
	dk_getOption(NOERROR ${ARGV})
	
	string(FIND ${path} "." includes REVERSE)
	if(${includes} EQUAL -1)
	#dk_includes(${path} "." includes REVERSE)
	#if(NOT includes)
		if(NOT NOERROR)
			dk_error("dk_removeExtension(${path}): no extension found")
		endif()
		return()
	endif()
	
	dk_getExtension(${path} ext)
	dk_replaceAll("${path}" "${ext}" "" removeExtension)
	#string(SUBSTRING ${path} 0 ${includes} removeExtension)
    set(${ret_var} ${removeExtension} PARENT_SCOPE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	set(myPath "C:/Users/yourname/awsomeFile.txt")
	dk_removeExtension("${myPath}" myPath)
	dk_info("${myPath}")
endfunction(DKTEST)