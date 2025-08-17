#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_chdir(path)
#
#	change working directory
#
dk_chdir() {
	dk_debugFunc 1;
	
	_path_=$1;
	
	if ! [ -e "${_path_}" ];then
		dk_call dk_warning "dk_chdir(${*}): path:${_path_} does not exist";
		return;
	fi
	
	if [ "${PWD}" = "${_path_}" ];then
		dk_call dk_error "dk_chdir(${*}): PWD is already set to ${_path_}";
		return;
	fi
	
	cd "${_path_}";
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_echo
	dk_call dk_echo "OLD Current Directory = ${OLDPWD-}"
	dk_call dk_echo "Current Directory = ${PWD}"
	
	dk_call dk_echo
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_chdir "${DKBRANCH_DIR}"
	dk_call dk_echo "OLD Current Directory = ${OLDPWD-}"
	dk_call dk_echo "Current Directory = ${PWD}"
	
	dk_call dk_echo
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_chdir "${DKTOOLS_DIR}"
	dk_call dk_echo "OLD Current Directory = ${OLDPWD-}"
	dk_call dk_echo "Current Directory = ${PWD}"
}
