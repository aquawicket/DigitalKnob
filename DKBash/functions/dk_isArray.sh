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


#alias dkreturn='x(){ echo "${1}"; return "${1}" }; x'
##############################################################################
# dk_isArray(variable) -> rtn_var
# 
#	Test if arg1 is an array variable
#
#	@variable	- The variable to test
#	@rtn_var: 	- True if the argument is an array variable, false if otherwise
#
#	https://stackoverflow.com/a/27254437
#
dk_isArray() {
	dk_debugFunc 1
	
	[[ "$(declare -p ${1})" =~ "declare -a" ]] && return $(true)
	return $(false)
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myVar1=(1 2 3)
	dk_isArray myVar1 && dk_echo "myVar1 is an array" || dk_echo "myVar1 is NOT an array"
	
	#dk_echo "dk_isArray myVar1 = $(dk_isArray myVar1)"
	
	#if dk_isArray myVar1; then
	#	dk_echo "myVar1 is an array"
	#else
	#	dk_echo "myVar1 is NOT an array"
	#fi
	
	
	
	
	myVar2="a b c"
	dk_isArray myVar2 && dk_echo "myVar2 is an array" || dk_echo "myVar2 is NOT an array"
	
	#dk_echo "dk_isArray myVar2 = $(dk_isArray myVar2)"
	
	#if dk_isArray myVar2; then
	#	dk_echo "myVar2 is an array"
	#else
	#	dk_echo "myVar2 is NOT an array"
	#fi
}
