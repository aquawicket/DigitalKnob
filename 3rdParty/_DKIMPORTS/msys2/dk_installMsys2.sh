#!/bin/sh
. ../../../DKBash/functions/DK
dk_includeGuard

##################################################################################
# dk_validateMsys2()
#
#
dk_validateMsys2 () {
	dk_debugFunc
	[ $# -gt 0 ] && dk_error "too many arguments"

	dk_validate DKIMPORTS_DIR dk_validateBranch
	dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
	dk_printVar MSYS2
	dk_printVar MSYS2_GENERATOR
}

dk_validateMsys2