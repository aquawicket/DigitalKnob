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
# dk_Target_App()
#
#
dk_Target_App() {
	dk_debugFunc 0 1;

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_App="${1}";
	
	###### GET ######	
	else
		echo " " ;
		
		### Target_App_Cache
		if [ -n "${Target_App_Cache-}" ]; then
			echo  "0) ${Target_App_Cache}";
			echo " ";
		fi
		### Target_App_Default
		if [ -z "${Target_App_Default-}" ]; then
			Target_App_Default="HelloWorld";
		fi
		echo " 1) ${Target_App_Default}";
		echo " 2) HelloWorld";
		echo " 3) DKPreprocessor";
		echo " 4) DKCore";
		echo " 5) DKJavascript";
		echo " 6) DKSDL";
		echo " 7) DKSDLRml";
		echo " 8) DKDomTest";
		echo " 9) DKTestAll";
		echo "10) Enter Manually";
		echo "11) Clear Screen";
		echo "12) Go Back";
		echo "13) Reload";
		echo "14) Exit";
		echo "";
	
		dk_call dk_keyboardInput input;
		#dk_call dk_keyboardInputTimeout input 1 60 
		
		  if [ "${input}" = "0" ]; then
			export Target_App="${Target_App_Cache}";
		elif [ "${input}" = "1" ]; then
			export Target_App="${Target_App_Default}";
		elif [ "${input}" = "2" ]; then
			export Target_App="HelloWorld";
		elif [ "${input}" = "3" ]; then
			export Target_App="DKPreprocessor";
		elif [ "${input}" = "4" ]; then
			export Target_App="DKCore";
		elif [ "${input}" = "5" ]; then
			export Target_App="DKJavascript";
		elif [ "${input}" = "6" ]; then
			export Target_App="DKSDL";
		elif [ "${input}" = "7" ]; then
			export Target_App="DKSDLRml";
		elif [ "${input}" = "8" ]; then
			export Target_App="DKDomTest";
		elif [ "${input}" = "9" ]; then
			export Target_App="DKTestAll";
		elif [ "${input}" = "10" ]; then
			dk_call dk_enterManually;
		elif [ "${input}" = "11" ]; then
			dk_call dk_clearScreen;
		elif [ "${input}" = "12" ]; then
			unset pickUpdate;
			return 1;
		elif [ "${input}" = "13" ]; then
			dk_call dk_reload;
		elif [ "${input}" = "14" ]; then
			dk_call dk_exit 0;
		else
			dk_call dk_warning "invalid selection";
		fi
	fi
	
	export ${Target_App}=1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	###### GET ######
    dk_call dk_Target_App;
	dk_call dk_debug "Target_App = ${Target_App}";
	dk_call dk_debug "${Target_App} = ${!Target_App}";
	
	###### SET ######
	dk_call dk_Target_App "MyApp";
	dk_call dk_debug "Target_App = ${Target_App}";
	dk_call dk_debug "${Target_App} = ${!Target_App}";
}
