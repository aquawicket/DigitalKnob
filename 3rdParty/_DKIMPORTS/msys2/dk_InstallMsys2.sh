#!/bin/sh
. ../../../DKBash/functions/DK.sh
dk_includeGuard

##################################################################################
# dk_validateMsys2()
#
#
dk_validateMsys2 () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_validate DKIMPORTS_DIR dk_validateBranch
	dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
	dk_debug MSYS2
	dk_debug MSYS2_GENERATOR
}

dk_validateMsys2