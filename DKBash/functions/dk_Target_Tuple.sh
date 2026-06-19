#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin;
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}";
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}";
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}";
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}";
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}";
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*;
fi
##################################################################################


#####################################################################
# dk_Target_Tuple()
#
#	  Target_Tuple = ${Target_Os}, ${Target_Arch} and ${Target_Env}  concatinated with underscores _
#
dk_Target_Tuple() {
	dk_debugFunc 0 1;

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Tuple="${1}";
	
	###### GET ######	
	else
		[ -z "${Target_Os-}" ] 		&& dk_call dk_Target_Os;
		[ -z "${Target_Arch-}" ]	&& dk_call dk_Target_Arch;
		[ -z "${Target_Env-}" ] 	&& dk_call dk_Target_Env;
		
		[ -n "${Target_Os-}" ] 		&& [ -n "${Target_Arch-}" ]									&& export Target_Tuple="${Target_Os}_${Target_Arch}";
		[ -n "${Target_Os-}" ] 		&& [ -n "${Target_Env-}" ]									&& export Target_Tuple="${Target_Os}_${Target_Env}";
		[ -n "${Target_Arch-}" ] 	&& [ -n "${Target_Env-}" ]									&& export Target_Tuple="${Target_Arch}_${Target_Env}";
		[ -n "${Target_Os-}" ] 		&& [ -n "${Target_Arch-}" ] 	&& [ -n "${Target_Env-}" ] 	&& export Target_Tuple="${Target_Os}_${Target_Arch}_${Target_Env}";
	fi
	
	export ${Target_Tuple}=1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Tuple;
	dk_call dk_debug "Target_Tuple = ${Target_Tuple}";
	dk_call dk_debug "${Target_Tuple} = ${!Target_Tuple}";
	
	###### SET ######
	dk_call dk_Target_Tuple "MyTuple";
	dk_call dk_debug "Target_Tuple = ${Target_Tuple}";
	dk_call dk_debug "${Target_Tuple} = ${!Target_Tuple}";
}
