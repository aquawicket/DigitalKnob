#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_call(<command args>)
#
dk_call(){
	dk_debugFunc 1 99
	#echo "dk_call($*)"
	#echo "dk_call($@)"
	
	#if ! (command -v '${1}' &>/dev/null); then
	#if ! (command -v '${1}'); then
	if ! $(declare -F "${1}" > /dev/null); then
		# Is it a dk_ prefixed function?
		#	if [[ "${1}" =~ ^dk_[a-zA-Z0-9]+ ]]; then
			dk_source ${1};	
		
		# Not a dk_ prefixed function
#		else								
#			(command -v dk_installPackage &>/dev/null) || dk_source dk_installPackage
#			dk_installPackage ${1}
#		fi
		
		if ! (command -v ${1} &>/dev/null); then
			(command -v dk_fatal &>/dev/null) || dk_source dk_fatal
			dk_fatal "${1}: command not found"
		fi
	fi
	
	
	#echo "CALL $*";
	#$*;
	
	#echo "CALL $@";
	"$@";
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	dk_debugFunc 0
	
	dk_call dk_info "test message using dk_call"
}
