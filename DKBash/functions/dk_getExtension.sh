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
# dk_getExtension(<path> <rtn_var>:optional)
#
#
dk_getExtension() {
	dk_debugFunc 1 2

	_filepath_="${1}";
	if ! [ "${_filepath_##*.tar.}" = "${_filepath_}" ]; then
		dk_getExtension=".tar.${_filepath_##*.tar.}";
	elif ! [ "${_filepath_##*.7z.}" = "${_filepath_}" ]; then
		dk_getExtension=".7z.${_filepath_##*.7z.}";
	elif ! [ "${_filepath_##*.}" = "${_filepath_}" ]; then 
		dk_getExtension=".${_filepath_##*.}";
	else
		echo "${_filepath_} has no extension";
	fi
	
	###### return ######
	export dk_getExtension=${dk_getExtension-};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_getExtension};
	else
		builtin echo "${dk_getExtension}";
	fi
	return $?;
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myPath "/test/test2/xfile.exten"
    dk_call dk_getExtension "${myPath}"
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.zip"
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.tar.gz"
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.tar.xz.tar.gz.tar.xz"
	dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.tar.x.gz"
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.tar.xz"
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.7z.exe.b"
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "test.7z.exe"
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
	
	dk_call dk_getExtension "File/Path/With/No/Extension";
    dk_call dk_echo "dk_getExtension = ${dk_getExtension}";
}
