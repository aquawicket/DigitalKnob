#!/bin/sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_install()
#
#
dk_install() {
	dk_call dk_debugFunc 0

	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	dk_call dk_assertVar GCC_C_COMPILER
	dk_call dk_assertVar GCC_CXX_COMPILER
}