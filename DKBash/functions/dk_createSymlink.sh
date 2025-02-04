#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_createSymlink(<path> <symlink>)
#
#
dk_createSymlink() {
	dk_debugFunc 2
	
	[ ! -e ${1} ] && dk_call dk_error "${1} does not exist"
	[ -e ${2} ] && dk_call dk_error "${2} already exists"
	ln -s ${1} ${2}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_createSymlink dk_createSymlink.sh dk_createSymlink
}
