#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_fileToArray(<path> <output>)
#
#  Read lines of a file into an array
#
#  reference: https://stackoverflow.com/a/49042678
#
dk_fileToArray() {
	dk_debugFunc 2

	OLDIFS=${IFS}
	IFS=$'\n' read -d '' -r -a lines < ${1} || $(true)
	IFS=${OLDIFS}
	
	### return value ###
	[ ${#} -gt 1 ] && eval ${2}='("${lines[@]}")' && return  	# return using parameter rtn_var
	dk_return "${lines[@]}" && return							# FIXME
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_fileToArray "${DKBASH_FUNCTIONS_DIR_}fileToVariable.txt" myArray
	dk_call dk_printVar myArray
}	
