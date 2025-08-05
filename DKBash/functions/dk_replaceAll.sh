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


##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" rtn_var)
#
#
dk_replaceAll() {
	dk_debugFunc 3 4;
	
    input="${1}";
	searchValue="${2}";
	newValue="${3}";
    dk_replaceAll=;
		
    while [ -n "${input}" ]; do
        LEFT=${input%%"${searchValue}"*};

        if [ "${LEFT}" = "${input}" ]; then
            dk_replaceAll=${dk_replaceAll}${input};
			break;
        fi

        dk_replaceAll=${dk_replaceAll}${LEFT}${newValue};
        input=${input#*"$searchValue"};
    done
	
	
	### return value ###
	export dk_replaceAll=${dk_replaceAll};
	if [ -n "${4-}" ]; then
		export ${4}=${dk_replaceAll};
	else
		builtin echo "${dk_replaceAll}";
	fi
	return $?;
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	dk_replaceAll "${string_var}" "Z" "B" string_var
	
	echo "string after:  ${string_var}"
}