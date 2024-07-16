#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_installMsys2()
#
#
dk_installMsys2() {
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	dk_cmakeEval "include('${DKIMPORTS_DIR}/msys2/DKMAKE.cmake')" "MSYS2"
	dk_printVar MSYS2
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_installMsys2
}