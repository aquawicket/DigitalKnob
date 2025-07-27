#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(dirname $0)                    				  && echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
ORIGINAL_IFS=${IFS}
##################################################################################
# dk_return()
#

alias dk_return='ret_val "${ret_val-}"'
ret_val() {
	#echo "ret_val(${2-})"
	if [ "${1-}" = "" ]; then
		[ -z "${2-}" ] && return $(false)
		re='^[0-9]+$'
		#[ -v "${2-}" ] && 
		if [[ ! ${2-} =~ ${re} ]]; then  # [ ${2-} -gt 9 ] = don't test names that match 0-9, positional parameters
			#echo "$(declare -p ${2-})"
			if [ -v "${2-}" ]; then
				if [[ "$(declare -p ${2-})" =~ "declare -a" ]]; then
					eval local array='("${'${2-}'[@]}")';
					printf "%s\n" "${array[@]}";
					export IFS=${ORIGINAL_IFS};
				fi
			fi
			return $(true);
		fi
		
		[ "${BASH_SUBSHELL}" = "0" ] || builtin echo "${2-}"
		#trap '' EXIT
		#exit
	else
		eval "${ret_val-}='${2-}'"
		unset ret_val
	fi
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_return "return string value"; return
}