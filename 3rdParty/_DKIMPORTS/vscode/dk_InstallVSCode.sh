echo "$0 $*"
#[ -n "$include_dk_" ] && exit || export readonly include_dk_=1
[ -z "$DKINIT" ] && . ../../../DKBash/functions/DK #$0

##################################################################################
# dk_InstallVSCode()
#
#
dk_InstallVSCode () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_cmakeEval "include('$DKIMPORTS_DIR/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	dk_debug VSCODE_EXE
}