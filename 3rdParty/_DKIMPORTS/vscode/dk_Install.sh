#!/bin/sh
[ -z "${DKINIT-}" ] && . ../../../DKBash/functions/DK.sh

##################################################################################
# dk_install()
#
#
dk_install() {
	dk_debugFunc 0

	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/vscode/DKMAKE.cmake')" "VSCODE_EXE"
	dk_call dk_assertVar VSCODE_EXE
}