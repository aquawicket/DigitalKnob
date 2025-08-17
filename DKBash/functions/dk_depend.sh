#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


############################################################################
# dk_depend(plugin)
#
#   this will search for a "plugin" to run in the following search path
#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.sh'
#
dk_depend() {
	dk_debugFunc 1 99;
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	export CURRENT_IMPORT="${DKIMPORTS_DIR}/${1}";
	dkInstall="${CURRENT_IMPORT}/DKINSTALL.sh";	
	if ! [ -e "${dkInstall}" ]; then
		dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR";
		dkhttpInstall="${dkInstall/${DIGITALKNOB_DIR}/${DKHTTP_DIGITALKNOB_DIR}}";
		dk_call dk_download "${dkhttpInstall}" "${dkInstall}"
	fi
	if ! [ -e "${dkInstall}" ]; then
		dk_call dk_fatal "dkInstall:${dkInstall} not found";
		return -1;
	fi
	
	dk_allButFirstArgs="${@:2}";
	dk_call dk_source "${dkInstall}";
	dk_call DKINSTALL ${dk_allButFirstArgs};
	return;
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_call dk_depend "git"
}
