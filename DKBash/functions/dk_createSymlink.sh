#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_createSymlink(<path> <symlink>)
#
#
dk_createSymlink() {
	dk_debugFunc 2

	
	[ ! -e ${1} ] && dk_error "${1} does not exist"
	[ -e ${2} ] && dk_error "${2} already exists"
	ln -s ${1} ${2}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 

	dk_createSymlink dk_createSymlink.sh dk_createSymlink
}