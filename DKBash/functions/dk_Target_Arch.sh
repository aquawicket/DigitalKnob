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
# dk_Target_Arch()
#
#	  Target_Os = Arm32, Arm64, X86, X86_64		Default = ${Host_Arch}
#
dk_Target_Arch() {
	dk_debugFunc 0 1;

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Arch="${1}";
	
	###### GET ######	
	else
		echo " ";
		
		### Target_Arch_Cache
		if [ -n "${Target_Arch_Cache-}" ]; then
			echo  "0) ${Target_Arch_Cache}";
			echo " ";
		fi
		### Target_Arch_Default
		if [ -z "${Target_Arch_Default-}" ]; then
			[ -z "${Host_Arch-}" ] && dk_call dk_Host_Arch;
			Target_Arch_Default="${Host_Arch}";
		fi
		echo " 1) ${Target_Arch_Default}";
		echo " 2) Arm32";
		echo " 3) Arm64";
		echo " 4) X86";
		echo " 5) X86_64";
		echo " ";

		dk_call dk_keyboardInput input;
		#dk_call dk_keyboardInputTimeout input 1 60;
		
		  if [ "${input}" = "0" ]; then
			export Target_Arch="${Target_Arch_Cache}";
		elif [ "${input}" = "1" ]; then
			export Target_Arch="${Target_Arch_Default}";
		elif [ "${input}" = "2" ]; then
			export Target_Arch="Arm32";
		elif [ "${input}" = "3" ]; then
			export Target_Arch="Arm64";
		elif [ "${input}" = "4" ]; then
			export Target_Arch="X86";
		elif [ "${input}" = "5" ]; then
			export Target_Arch="X86_64";
		else
			dk_call dk_warning "invalid selection";
		fi
	fi
	
	export ${Target_Arch}=1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Arch;
	dk_call dk_debug "Target_Arch = ${Target_Arch}";
	dk_call dk_debug "${Target_Arch} = ${!Target_Arch}";
	
	###### SET ######
	dk_call dk_Target_Arch "MyArch";
	dk_call dk_debug "Target_Arch = ${Target_Arch}";
	dk_call dk_debug "${Target_Arch} = ${!Target_Arch}";
}