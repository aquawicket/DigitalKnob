#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_minMaxArgs(min, max)
#
minMaxArgs() {
	
	_FUNCNAME_=${1-}
	_ARGC_=${2-}
	_ARGS_="${3-}"
	_MIN_=${4-}
	_MAX_=${5-}
	[ -z ${_MIN_} ] && _MIN_=0
	[ -z ${_MAX_} ] && _MAX_=0
	echo "####### ${_FUNCNAME_} ${_ARGC_} ${_ARGS_} ${_MIN_} ${_MAX_} #########################"
	
	[ ${_ARGC_} -lt ${_MIN_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): not enough arguments. Minimum is ${_MIN_}, got ${_ARGC_}" || $(true)
	[ -z ${_MAX_} ] && [ ${_ARGC_} -gt ${_MIN_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): too many arguments. Maximum is ${_MIN_}, got ${_ARGC_}" || $(true)
	[ -n ${_MAX_} ] && [ ${_ARGC_} -gt ${_MAX_} ] && dk_error "${_FUNCNAME_}(${_ARGC_}): too many arguments. Maximum is ${_MAX_}, got ${_ARGC_}" || $(true)
}


alias dk_minMaxArgs='minMaxArgs ${FUNCNAME} ${#} "${*}"'
