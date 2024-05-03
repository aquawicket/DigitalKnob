echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


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