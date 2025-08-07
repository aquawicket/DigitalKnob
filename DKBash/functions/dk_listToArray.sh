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


################################################################################
# dk_listToArray(<list>, <rtn_var:OPTIONAL>)
#
#
dk_listToArray() {
    dk_debugFunc 1 2;
    
	OLDIFS=${IFS};
	IFS=";"
	dk_listToArray=(${1}); #NOTE: ${1/;;/;} fixes the issue of empty array items from strings containng ";;"
	IFS=${OLDIFS};
	#for i in ${arr[@]}; do echo $i; done
	
	
	###### output ######
	export dk_listToArray=${dk_listToArray};
	if [ -n "${2-}" ]; then
		#export ${2}=${dk_listToArray};
		eval ${2}='("${dk_listToArray[@]}")';
	else
		builtin echo "${dk_listToArray[@]}";
	fi
	return $?;
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;

	### Result as global variable
	dk_call dk_echo;
	dk_call dk_listToArray "a;b;c;d;e;f;g";
	dk_call dk_printVar dk_listToArray;
	
	### Result as parameter
	dk_call dk_echo;
	dk_call dk_listToArray "1;2;3;4;5;6;7" resultB;
	dk_call dk_printVar resultB;
	dk_call dk_printVar dk_listToArray;
	
	### Result as return value
	dk_call dk_echo;
	resultC=($(dk_call dk_listToArray "z;y;x;w;v;t;s"));
	dk_call dk_printVar resultC;
	#dk_call dk_printVar dk_listToArray;					#NOTE: export cannot be seen outside of command substituion
}
