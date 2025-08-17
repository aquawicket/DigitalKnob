#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


###############################################################################
# dk_validate(<variable> <code>)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid.
#
dk_validate() {
	dk_debugFunc 2
	#echo "dk_validate($*)"
	
	#_var_=${1}
	#_code_=${2}
	[ -n "${!1+x}" ] && return 0
	
	#echo "2 = ${2}"
	
	#[ -e "${DKBASH_FUNCTIONS_DIR}/${2-}.sh" ] && dk_call dk_source ${2}
	
	${2}
	#eval "${2}"
	
	[ -n "${!1+x}" ] || dk_call dk_error "dk_call dk_validate(): ${1} is invalid"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myVarA="a valid variable"
	dk_call dk_validate myVarA fill_myVarA
	echo "myVarA = ${myVarA}"
		
	dk_call dk_validate myVarB fill_myVarB
	echo "myVarB = ${myVarB}"
	
	dk_call dk_validate myVarC "myVarC='a string value'"
	echo "myVarC = ${myVarC}"
	
	dk_call dk_validate myVarD "echo 'this will not fill myVarD'"
	echo "myVarD = ${myVarD}"
}

fill_myVarA() {
	myVarA="myVarA has a string value"
}

fill_myVarB() {
	myVarB="myVarB has a string value"
}
