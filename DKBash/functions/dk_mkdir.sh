#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


#####################################################################
# dk_mkdir(<path>)
#
#
dk_mkdir() {
	dk_debugFunc 1

	
	mkdir -p "${1}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_mkdir test
}