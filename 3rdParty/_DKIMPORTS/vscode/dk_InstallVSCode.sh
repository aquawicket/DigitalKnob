#!/bin/sh
[ -z "${DKINIT}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_installVSCode()
#
#
dk_installVSCode (){
	dk_debugFunc
	[ ${#} -gt 0 ] && dk_error "too many arguments"

	dk_cmakeEval "include('${DKIMPORTS_DIR}/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	dk_printVar VSCODE_EXE
}