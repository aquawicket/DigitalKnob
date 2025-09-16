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
# dk_removeExtension(<filepath> <output>)
#
#
dk_removeExtension() {
	dk_debugFunc 1 2;

	_filepath_="${1}";
	if ! [ "${_filepath_##*.tar.}" = "${_filepath_}" ]; then
		dk_removeExtension="${_filepath_%.tar.*}";
	elif ! [ "${_filepath_##*.7z.}" = "${_filepath_}" ]; then
		dk_removeExtension="${_filepath_%.7z.*}";
	else
		dk_removeExtension="${_filepath_%.*}";
	fi
	
	###### output ######
	export dk_removeExtension=${dk_removeExtension};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_removeExtension};
	else
		builtin echo "${dk_removeExtension}";
	fi
	return $?;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	### Result as global variable
	dk_call dk_echo
	dk_call dk_removeExtension "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_removeExtension "B:/directoryB/filenameB.tar.gz" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
	
	### Result as return value
	dk_call dk_echo
	resultC=$(dk_call dk_removeExtension "C:/directoryC/filenameC.target.gz");
	dk_call dk_echo "resultC = ${resultC}";
	#dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";					#NOTE: export cannot be seen outside of command substituion
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_removeExtension "D:/directoryD/filenameD" resultD;
	dk_call dk_echo "resultD = ${resultD}";
	dk_call dk_echo "dk_removeExtension = ${dk_removeExtension}";
}