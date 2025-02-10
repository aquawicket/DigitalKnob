#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_installMsys2()
#
#
dk_installMsys2() {
	dk_debugFunc 0


	dk_cmakeEval "include('${DKIMPORTS_DIR}/msys2/DKMAKE.cmake')" "MSYS2"
	dk_printVar MSYS2
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_installMsys2
}