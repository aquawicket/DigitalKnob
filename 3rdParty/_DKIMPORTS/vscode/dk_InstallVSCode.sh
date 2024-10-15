#!/bin/sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_installVSCode()
#
#
dk_installVSCode() {
	dk_debugFunc 0


	dk_cmakeEval "include('${DKIMPORTS_DIR}/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	dk_printVar VSCODE_EXE
}