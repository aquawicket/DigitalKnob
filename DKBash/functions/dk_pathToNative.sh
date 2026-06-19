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
# dk_pathToNative(path output:OPTIONAL)
#
#
dk_pathToNative() {
	dk_debugFunc 1 2;
	
	#_path_="${1-}";
	
	dk_call dk_validate Host_Os "dk_call dk_Host_Os";
	
	### Windows
	if [ "${Host_Os}" = "Windows" ]; then
		dk_call dk_pathToWindows "${1}" dk_pathToNative;
	### Unix
	else
		dk_pathToNative="$(dk_readlink -f "${1}")";
	fi
	
	
	###### return ######
	export dk_pathToNative=${dk_pathToNative};
	if [ -n "${2-}" ]; then
		eval ${2}=${dk_pathToNative};
	else
		builtin echo "${dk_pathToNative}";
	fi
	return $?;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as global variable ###";
	dk_call dk_pathToNative "C:/Windows/System32";
	dk_call dk_debug "dk_pathToNative      = '${dk_pathToNative}'";
	
	### Result as variable parameter ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as variable parameter ###";
	dk_call dk_pathToNative "C:/Windows/System32" myNativePathA;
	dk_call dk_debug "dk_pathToNative      = '${dk_pathToNative}'";
	dk_call dk_debug "myNativePathA        = '${myNativePathA}'";

	### Result as return value ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as return value ###";
	myNativePathB=$(dk_call dk_pathToNative "C:/Windows/System32");
#	dk_call dk_debug "dk_pathToNative      = '${dk_pathToNative}'"		#NOTE: export cannot be seen outside of command substituion
	dk_call dk_debug "myNativePathB        = '${myNativePathB}'";

	### Result as hashtable parameter ###
	dk_call dk_debug;
	dk_call dk_debug "### Result as hashtable parameter ###";
	declare -A -x myNativePathC;
	dk_call dk_pathToNative "C:/Windows/System32" myNativePathC[value];
	dk_call dk_debug "dk_pathToNative      = '${dk_pathToNative}'";
	dk_call dk_debug "myNativePathC[value] = '${myNativePathC[value]}'";

}
