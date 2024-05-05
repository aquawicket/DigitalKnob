echo "$0 $*"
#[ -n "$include_dk_" ] && exit || export readonly include_dk_=1
[ -z "$DKINIT" ] && . ../../../DKBash/functions/DK #$0

##################################################################################
# dk_validateGcc()
#
#
dk_validateGcc () {
	dk_debugFunc
	[ $# -gt 0 ] && dk_error "too many arguments"

	dk_cmakeEval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	dk_printVar GCC_C_COMPILER
	dk_printVar GCC_CXX_COMPILER
}