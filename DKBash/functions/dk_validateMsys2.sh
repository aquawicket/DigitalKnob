#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_validateMsys2()
#
#
dk_validateMsys2 () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
	dk_debug MSYS2
}