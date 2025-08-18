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
# dk_basename(_path, _rtn_var)
#
#	Strip directory and suffix from filenames
#
#	Reference: https://en.wikipedia.org/wiki/Basename
#
dk_basename() {
	dk_debugFunc 1 2;
	
	###### input ######
	# ${1} = _path
	# ${2} = _rtn_var (optional)
	
	
	dk_basename="$(basename ${1})";


	###### output ######
	export dk_basename=${dk_basename};
	if [ -n "${2-}" ]; then
		eval ${2}=${dk_basename};
	else
		builtin echo "${dk_basename}";
	fi
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_basename "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as variable parameter
	dk_call dk_echo;
	dk_call dk_basename "B:/directoryB/filenameB.extB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
	
	### Result as return value
	dk_call dk_echo;
	resultC=$(dk_call dk_basename "C:/directoryC/filenameC.extC");
	dk_call dk_echo "resultC = ${resultC}";
	#dk_call dk_echo "dk_basename = ${dk_basename}"					#NOTE: export cannot be seen outside of command substituion
	
	### Result as hashtable parameter
	declare -A -x resultD;
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_basename "D:/directoryD/filenameD.extD" resultD[value];
	dk_call dk_echo "resultD[value] = ${resultD[value]}";
	dk_call dk_echo "dk_basename = ${dk_basename}";
}
