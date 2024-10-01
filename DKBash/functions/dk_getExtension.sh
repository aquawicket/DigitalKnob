#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_getExtension(<path> <output>)
#
#
dk_getExtension() {
	dk_debugFunc 1 2

	_filename_=$(dk_call dk_basename "${1}")
	eval "_extension_=${_filename_##*.}"
	
	### return value ###
	dk_call dk_printVar _extension_
	[ ${#} -gt 1 ] && eval "${2}=${_extension_}" && return  # return value when using rtn_var parameter 
	dk_return ${_extension_}; return						  # return value when using command substitution 
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getExtension "TestFile.txt" extension
	dk_call dk_echo "extension = ${extension}"
}
