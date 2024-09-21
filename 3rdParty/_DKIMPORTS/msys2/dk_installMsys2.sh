#!/bin/sh
. ../../../DKBash/functions/DK.sh
dk_includeGuard

##################################################################################
# dk_installMsys2()
#
#
dk_installMsys2() {
	dk_debugFunc 0


	dk_validate DKIMPORTS_DIR "dk_validateBranch"
	dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR;CLANG64_EXE"
	dk_printVar MSYS2
	dk_printVar MSYS2_GENERATOR
	dk_printVar CLANG64_EXE
}

dk_installMsys2