#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getExtension(<path> <output>)
#
#
dk_getExtension (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	_filename_=$(dk_basename "${1}")
	eval "${2}=${_filename_##*.}"
	dk_printVar "${2}"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_getExtension "TestFile.txt" extension
	dk_echo "extension = ${extension}"
}
