#!/bin/sh
[ -z "${DKINIT}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_installUnzip()
#
#
dk_installUnzip() {
	dk_debugFunc
	[ ${#} -gt 0 ] && dk_error "too many arguments"

	dk_install unzip
	#dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')"
}