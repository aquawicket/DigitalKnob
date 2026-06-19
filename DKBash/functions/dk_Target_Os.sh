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
# dk_Target_Os()
#
#	Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows	Default = ${Host_Os}
#
dk_Target_Os() {
	dk_debugFunc 0 1;

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Os="${1}";
	
	###### GET ######	
	else
		echo " ";
		
		### Targt_Os_Cache
		if [ -n "${Target_Os_Cache-}" ]; then
			echo  "0) ${Target_Os_Cache}";
			echo " ";
		fi
		### Target_Os_Default
		if [ -z "${Target_Os_Default-}" ]; then
			[ -z "${Host_Os-}" ] && dk_call dk_Host_Os;
			Target_Os_Default="${Host_Os}";
		fi
		echo " 1) ${Target_Os_Default}";
		echo " 2) Android";
		echo " 3) Cosmopolitan";
		echo " 4) Emscripten";
		echo " 5) Ios";
		echo " 6) Iossim";
		echo " 7) Linux";
		echo " 8) Mac";
		echo " 9) Raspberry";
		echo "10) Windows";
		echo " ";

		dk_call dk_keyboardInput input;
		#dk_call dk_keyboardInputTimeout input 1 60;
		
		  if [ "${input}" = "0" ]; then
			export Target_Os="${Target_Os_Cache}";
		elif [ "${input}" = "1" ]; then
			export Target_Os="${Target_Os_Default}";
		elif [ "${input}" = "2" ]; then
			export Target_Os="Android";
		elif [ "${input}" = "3" ]; then
			export Target_Os="Cosmopolitan";
		elif [ "${input}" = "4" ]; then
			export Target_Os="Emscripten";
		elif [ "${input}" = "5" ]; then
			export Target_Os="Ios";
		elif [ "${input}" = "6" ]; then
			export Target_Os="Iossim";
		elif [ "${input}" = "7" ]; then
			export Target_Os="Linux";
		elif [ "${input}" = "8" ]; then
			export Target_Os="Mac";
		elif [ "${input}" = "9" ]; then
			export Target_Os="Raspberry";
		elif [ "${input}" = "10" ]; then
			export Target_Os="Windows";
		else
			dk_call dk_warning "invalid selection";
		fi
	fi
	
	export ${Target_Os}=1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Os;
	dk_call dk_debug "Target_Os = ${Target_Os}";
	dk_call dk_debug "${Target_Os} = ${!Target_Os}";
	
	###### SET ######
	dk_call dk_Target_Os "MyOs";
	dk_call dk_debug "Target_Os = ${Target_Os}";
	dk_call dk_debug "${Target_Os} = ${!Target_Os}";
}
