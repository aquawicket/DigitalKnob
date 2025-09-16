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


##################################################################################
# dk_trimNonAlphaNumeric(<input> <output>)
#
#
dk_trimNonAlphaNumeric() {
	dk_debugFunc 1 2
	
	#VAR="head:string:tail"
	#${VAR##*:} 	= tail             //trim from the head -> till the last ':'
	#${VAR#*:}  	= string:tail      //trim from the head -> till the first ':' 
	#${VAR%%:*} 	= head             //trim from the tail <- till the last ':'
	#${VAR%:*}  	= head:string      //trim from the tail <- till the first ':'
	#VAR2=${VAR%:*} = head:string      //VAR2="head:string"
	#${VAR2#*:} 	= string           //trim from the head -> till the first ':' 
	
	f="${1#"${1%%[[:alnum:]]*}"}";
	dk_trimNonAlphaNumeric="${f%"${f##*[[:alnum:]]}"}";
	
	
	###### output ######
	export dk_trimNonAlphaNumeric=${dk_trimNonAlphaNumeric};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_trimNonAlphaNumeric};
	else
		builtin echo "${dk_trimNonAlphaNumeric}";
	fi
	return $?;
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	myVar="++0.2.134Beta--";
	dk_call dk_trimNonAlphaNumeric "${myVar}";
	dk_call dk_echo "dk_trimNonAlphaNumeric = ${dk_trimNonAlphaNumeric}";
}
