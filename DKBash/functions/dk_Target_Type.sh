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


##################################################################################
# dk_Target_Type()
#
#	Target_Type = Release, Debug	Default = Release
#
dk_Target_Type() {
	dk_debugFunc 0 1;

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Type="${1}";
	
	###### GET ######	
	else
		echo " ";
		
		### Target_Type_Cache
		if [ -n "${Target_Type_Cache-}" ]; then
			echo  "0) ${Target_Type_Cache}";
			echo " ";
		fi
		### Target_Type_Default
		if [ -z "${Target_Type_Default-}" ]; then
			Target_Type_Default="Release";
		fi
		echo " 1) ${Target_Type_Default}";
		echo " 2) Release";
		echo " 3) Debug";
		echo " 4) All";
		echo " 5) Clear Screen";
		echo " 6) Go Back";
		echo " 7) Exit";
		echo " ";
	
		dk_call dk_keyboardInput input;
		#dk_call dk_keyboardInputTimeout input 1 60;
	
		  if [ "${input}" = "0" ]; then
			export Target_Type="${Target_Type_Cache}";
		elif [ "${input}" = "1" ]; then
			export Target_Type="${Target_Type_Default}";
		elif [ "${input}" = "2" ]; then
			export Target_Type="Release";
		elif [ "${input}" = "3" ]; then
			export Target_Type="Debug";
		elif [ "${input}" = "4" ]; then
			export Target_Type="All";
		elif [ "${input}" = "5" ]; then
			dk_call dk_clearScreen;
		elif [ "${input}" = "6" ]; then
			unset Target_Tuple;
			return 1;
		elif [ "${input}" = "7" ]; then
			dk_call dk_exit 0;
		else
			dk_call dk_warning "invalid selection";
		fi
	fi
		
	export ${Target_Type}=1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	###### GET ######
    dk_call dk_Target_Type;
	dk_call dk_debug "Target_Type = ${Target_Type}";
	dk_call dk_debug "${Target_Type} = ${!Target_Type}";
	
	###### SET ######
	dk_call dk_Target_Type "MyType";
	dk_call dk_debug "Target_Type = ${Target_Type}";
	dk_call dk_debug "${Target_Type} = ${!Target_Type}";
}
