#!/bin/sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_installGcc()
#
#
dk_installGcc() {
	dk_debugFunc 0


	dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	dk_printVar GCC_C_COMPILER
	dk_printVar GCC_CXX_COMPILER
}