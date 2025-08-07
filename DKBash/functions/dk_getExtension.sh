#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
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
	
	### return value ###
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
