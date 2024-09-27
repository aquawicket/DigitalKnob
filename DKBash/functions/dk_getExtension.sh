#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_getExtension(<path> <output>)
#
#
dk_getExtension() {
	dk_debugFunc 2

	_filename_=$(dk_call dk_basename "${1}")
	eval "${2}=${_filename_##*.}"
	dk_call dk_printVar "${2}"
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getExtension "TestFile.txt" extension
	dk_call dk_echo "extension = ${extension}"
}
