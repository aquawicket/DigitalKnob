#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_gitCheckRemote()
#
#
dk_gitCheckRemote() {
	dk_debugFunc 0
	#echo "dk_gitCheckRemote($*)"
	
	ahead=0
	behind=0
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		dk_call dk_validate git_exe "dk_call dk_depend git"
		${git_exe} -C ${DKBRANCH_DIR} remote update
		branch=$(${git_exe} -C ${DKBRANCH_DIR} rev-parse --abbrev-ref HEAD)
		ahead=$(${git_exe} -C ${DKBRANCH_DIR} rev-list --count origin/${branch}..${branch})
		behind=$(${git_exe} -C ${DKBRANCH_DIR} rev-list --count ${branch}..origin/${branch})
		dk_call dk_info "${ahead} commits ahead, ${behind} commits behind"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCheckRemote
}
