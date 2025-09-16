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


#####################################################################
[ -z ${Target_Env_Default-} ] && Target_Env_Default="Clang"
#####################################################################
# dk_Target_Env()
#
#	  Target_Env = Arm32, Arm64, X86, X86_64
#
dk_Target_Env() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		Target_Env="${1-}"
	
	###### GET ######	
	else
		echo " " 
		### if not defined Target_Env_Cache (dk_call dk_Target_Env_Cache)
		if [ -n "${Target_Env_Cache-}" ]; then
			echo  "0) ${Target_Env_Cache-}"
			echo " "
		fi
		echo " 1) ${Target_Env_Default}"
		echo " 2) Clang"
		echo " 3) Gcc"
		echo " 4) Msvc"
		echo " "

		dk_call dk_keyboardInput input
		
		  if [ "${input}" = "0" ]; then
			export Target_Env="${Target_Env_Cache}"
		elif [ "${input}" = "1" ]; then
			export Target_Env="${Target_Env_Default}"
		elif [ "${input}" = "2" ]; then
			export Target_Env="Clang"
		elif [ "${input}" = "3" ]; then
			export Target_Env="Gcc"
		elif [ "${input}" = "4" ]; then
			export Target_Env="Msvc"
		fi
	fi
	
	export ${Target_Env}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Env
	dk_call dk_printVar Target_Env
	dk_call dk_printVar ${Target_Env}
	
	###### SET ######
	dk_call dk_Target_Env "Windows"
	dk_call dk_printVar Target_Env
	dk_call dk_printVar ${Target_Env}	
}