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
# dk_convertToCIdentifier(<input> <output>)
#
#
dk_convertToCIdentifier() {
	dk_debugFunc 1 2

	dk_convertToCIdentifier="${1//[^[:alnum:]]/_}";		# BASH alpha_numeric_replace
#	dk_call dk_replaceAll "${input}" "-" "_" input		# POSIX replace
#	dk_call dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" " " "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "=" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ";" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "," "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "!" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "@" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "#" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "$" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "%" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "&" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "*" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "(" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ")" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "+" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "|" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ":" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "[" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "]" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "\" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "'" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "/" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "~" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" """ "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "?" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "<" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ">" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "{" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "}" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "`" "_" output		# POSIX replace
	
	
	###### return ######
	export dk_convertToCIdentifier=${dk_convertToCIdentifier};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_convertToCIdentifier};
	else
		builtin echo "${dk_convertToCIdentifier}";
	fi
	return $?;
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	myVar="a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	dk_call dk_convertToCIdentifier "${myVar}" myAlphaNumericVar
	dk_call dk_echo "myAlphaNumericVar = ${myAlphaNumericVar}"
}
