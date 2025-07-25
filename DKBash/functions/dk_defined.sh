#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_defined(variable)
#
# Evaluates to true if the parameter is a variable that exists.
#
dk_defined() {
	dk_debugFunc 1
	
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)   # ^ as first character is not portable
	# FIXME:  the errors out on zsh
	
	#$(expr "${1}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	#[[ ${1} ~= [A-Za-z0-9_]\+$ ]] || return $(false)
	
	#dk_call dk_echo "${green}${name} is [:word:]${clr}"
	
	#eval value='$'{${1}+x} # value will = 'x' if the variable is defined
	
	[ -n "${!1+1}" ]
	#dk_call dk_echo "dk_defined():value = ${value}"
	#[ -n "${value}" ]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	varA="A simple string variable"
	if dk_call dk_defined varA; then
		dk_call dk_echo "varA is defined"
	else
		dk_call dk_echo "varA is NOT defined"
	fi
	
	#varB="A non existent variable"
	if dk_call dk_defined varB; then
		dk_call dk_echo "varB is defined"
	else
		dk_call dk_echo "varB is NOT defined"
	fi
}
