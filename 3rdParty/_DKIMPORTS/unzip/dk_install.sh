#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_install
#
dk_install() {
	dk_debugFunc 0

	dk_call dk_installPackage unzip
	#dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')"
}