#!/bin/sh
echo "################## dk_testRestun.sh($*) ##################";

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
# dk_testReturn(input, output)
#
#
dk_testReturn() {
	echo "################## dk_testRestun($*) ##################";
	dk_debugFunc 1 2;
	
	export dk_testReturn=${1/input/output};

	if [ -n "${2-}" ]; then
		export ${2}=${dk_testReturn};
	else
		echo "${dk_testReturn}";
	fi
	return $?;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#echo "################## dk_testRestun:DKTEST($*) ##################";
	dk_debugFunc 0
	
	### Result as global variable							[GLOBAL]
	dk_call dk_echo;
	dk_call dk_testReturn "inputA";
	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	### Result as parameter variable						[GLOBAL][PARAM]
	dk_call dk_echo;
	dk_call dk_testReturn "inputB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	### Result as return value								[-G̶L̶O̶B̶A̶L̶-][RETURN]
	dk_call dk_echo;
	resultC=$(dk_call dk_testReturn "inputC");
	dk_call dk_echo "resultC = ${resultC}";
	#dk_call dk_echo "dk_testReturn = ${dk_testReturn}";	#NOTE: export cannot be seen outside of command substituion
	
	### Result as return value and parameter variable 		[GLOBAL][-P̶A̶R̶A̶M̶ ][-R̶E̶T̶U̶R̶N̶ ]
	#dk_call dk_echo;
	#resultE=$(dk_call dk_testReturn "inputDE" resultD);
	#dk_call dk_echo "resultD = ${resultD-}";
	#dk_call dk_echo "resultE = ${resultE}";
	#dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	
	### Result from stdout									[STDOUT]
	dk_call dk_echo
	BASH_EXE="/bin/bash";
	unset DK_LOADED;
	export DK_LOADED;
	export DKTEST="OFF";
	#resultF="$(bash -c '/mnt/c/Users/Administrator/DigitalKnob/Development/DKBash/functions/dk_testReturn.sh "inputF"')";
	resultF="$(bash -c '/mnt/c/Users/Administrator/DigitalKnob/Development/DKBash/functions/dk_testReturn.sh inputF')";
	#resultF="$(bash -c 'dk_testReturn inputF')";
	dk_call dk_echo "resultF = '${resultF}'";
	#dk_call dk_echo "dk_testReturn = ${dk_testReturn}";
	#dk_call dk_echo "exit_code = ${exit_code}";
}
