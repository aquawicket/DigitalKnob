#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
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
		dk_call dk_validate GIT_EXE "dk_call dk_depend git"
		${GIT_EXE} -C ${DKBRANCH_DIR} remote update
		branch=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-parse --abbrev-ref HEAD)
		ahead=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-list --count origin/${branch}..${branch})
		behind=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-list --count ${branch}..origin/${branch})
		dk_call dk_info "${ahead} commits ahead, ${behind} commits behind"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCheckRemote
}
