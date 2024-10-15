#!/bin/sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_installUnzip()
#
#
dk_installUnzip() {
	dk_debugFunc 0


	dk_installPackage unzip
	#dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')"
}