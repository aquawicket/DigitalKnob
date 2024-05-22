echo "$0 $*"
#[ -n "$include_dk_" ] && exit || export readonly include_dk_=1
[ -z "$DKINIT" ] && . ../../../DKBash/functions/DK.sh #$0

##################################################################################
# dk_installVSCode()
#
#
dk_installVSCode () {
	dk_debugFunc
	[ $# -gt 0 ] && dk_error "too many arguments"

	dk_cmakeEval "include('${DKIMPORTS_DIR}/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	dk_printVar VSCODE_EXE
}