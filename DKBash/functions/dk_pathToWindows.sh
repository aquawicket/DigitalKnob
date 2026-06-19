#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_pathToWindows(_path_ output:OPTIONAL)
#
#
dk_pathToWindows() {
	dk_debugFunc 1 2

	dk_call dk_validate cygpath_exe "dk_call dk_depend cygpath_exe";
	local dk_pathToWindows=$(${cygpath_exe} -w "${1}");
	dk_pathToWindows="${dk_pathToWindows//\\/\\\\}";
	
	###### return ######
	export dk_pathToWindows=${dk_pathToWindows};
	if [ -n "${2-}" ]; then
		eval ${2}=${dk_pathToWindows};
	else
		builtin echo "${dk_pathToWindows}";
	fi
	return $?;
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	### Result as global variable ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as global variable ###";
	dk_call dk_pathToWindows "C:/Windows/System32";
	dk_call dk_debug "dk_pathToWindows      = '${dk_pathToWindows}'";
	
	### Result as variable parameter ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as variable parameter ###";
	dk_call dk_pathToWindows "C:/Windows/System32" myWindowsPathA;
	dk_call dk_debug "dk_pathToWindows      = '${dk_pathToWindows}'";
	dk_call dk_debug "myWindowsPathA        = '${myWindowsPathA}'";

	### Result as return value ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as return value ###";
	myWindowsPathB=$(dk_call dk_pathToWindows "C:/Windows/System32");
#	dk_call dk_debug "dk_pathToWindows      = '${dk_pathToWindows}'"		#NOTE: export cannot be seen outside of command substituion
	dk_call dk_debug "myWindowsPathB        = '${myWindowsPathB}'";

	### Result as hashtable parameter ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as hashtable parameter ###";
	declare -A -x myWindowsPathC;
	dk_call dk_pathToWindows "C:/Windows/System32" myWindowsPathC[value];
	dk_call dk_debug "dk_pathToWindows      = '${dk_pathToWindows}'";
	dk_call dk_debug "myWindowsPathC[value] = '${myWindowsPathC[value]}'";
}
