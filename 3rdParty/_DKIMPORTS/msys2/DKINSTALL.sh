#!/usr/bin/env sh
. ../../../DKBash/functions/DK.sh
dk_includeGuard

##################################################################################
# dk_install()
#
#
dk_install() {
	dk_debugFunc 0

	dk_call dk_validate DKIMPORTS_DIR "dk_DKIMPORTS_DIR"
	dk_call dk_cmakeEval "include('$DKIMPORTS_DIR/msys2/DKINSTALL.cmake')" "MSYS2;MSYS2_GENERATOR;CLANG64_EXE"
	dk_call dk_assertVar MSYS2
	dk_call dk_assertVar MSYS2_GENERATOR
	dk_call dk_assertVar CLANG64_EXE
}

dk_install