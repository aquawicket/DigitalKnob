<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

################################################################################
# dk_fileToArray(<path> <output>)
#
#  Read lines of a file into an array
#
#  reference: https://stackoverflow.com/a/49042678
#
dk_fileToArray() {
	dk_debugFunc 2

<<<<<<< HEAD
	dk_call dk_todo
=======
	OLDIFS=${IFS}
	IFS=$'\n' read -d '' -r -a lines < ${1} || $(true)
	IFS=${OLDIFS}
	
	### return value ###
	[ ${#} -gt 1 ] && eval ${2}='("${lines[@]}")' && return  	# return using parameter rtn_var
	dk_return "${lines[@]}" && return							# FIXME
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

<<<<<<< HEAD
	dk_call dk_fileToArray
=======
	dk_call dk_fileToArray "${DKBASH_FUNCTIONS_DIR_}fileToVariable.txt" myArray
	dk_call dk_printVar myArray
>>>>>>> Development
}	
