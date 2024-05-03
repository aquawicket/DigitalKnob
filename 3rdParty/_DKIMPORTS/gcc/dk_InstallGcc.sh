echo "$0 $*"
#[ -n "$include_dk_" ] && exit || export readonly include_dk_=1
[ -z "$DKINIT" ] && . ../../../DKBash/functions/DK.sh #$0

##################################################################################
# dk_validateGcc()
#
#
dk_validateGcc () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	dk_debug GCC_C_COMPILER
	dk_debug GCC_CXX_COMPILER
}