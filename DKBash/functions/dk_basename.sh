<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_basename(path, rtn_var)
#
#	https://en.wikipedia.org/wiki/Basename
#
dk_basename() {
	dk_debugFunc 1 2
	
<<<<<<< HEAD
	#local _basename_=$(basename "${1}")
	_basename_=$(basename "${1}")

	### return value ###
	#dk_call dk_printVar _basename_ 	# ERROR: causes infinate loop
	[ ${#} -gt 1 ] && eval "${2}=${_basename_}" && return $?	# return value when using rtn_var parameter 
	dk_return ${_basename_}; return	$?				      		# return value when using command substitution
	
#DEBUG
#	dk_call dk_printVar _basename_
=======
	#local dk_basename=$(basename "${1}")
	dk_basename=$(basename "${1}")

	### return value ###
	#dk_call dk_printVar dk_basename 	# ERROR: causes infinate loop
	[ ${#} -gt 1 ] && eval "${2}=${dk_basename}" && return $?	# return value when using rtn_var parameter 
	dk_return ${dk_basename}; return	$?				      		# return value when using command substitution
	
#DEBUG
#	dk_call dk_printVar dk_basename
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	basenameA=$(dk_call dk_basename "/path/to/a/filename.txt")
	dk_call dk_echo "basenameA = ${basenameA}"
	
	dk_call dk_basename "/path/to/a/filename.txt" basenameB
	dk_call dk_echo "basenameB = ${basenameB}"
=======
	dk_call dk_basename "/path/to/a/filenameA.txt"
	dk_call dk_echo "dk_basename = ${dk_basename}"
	
	basenameB=$(dk_call dk_basename "/path/to/a/filenameB.txt")
	dk_call dk_echo "basenameB = ${basenameB}"
	
	dk_call dk_basename "/path/to/a/filenameC.txt" basenameC
	dk_call dk_echo "basenameC = ${basenameC}"
	
	dk_call dk_basename "/path/to/a/filenameD.txt" basenameD
	dk_call dk_echo "dk_basename = ${dk_basename}"
	dk_call dk_echo "basenameD = ${basenameD}"
>>>>>>> Development
}
