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
# dk_assertVar(expression)
#
#
dk_assertVar() {
	dk_debugFunc 1

	if ( [ ! -n "${!1-}" ]  ||
         [ -z "${!1}" ]     ||
         [ ! -n "${!1+x}" ] )
	then
		dk_call dk_error "Assertion failed: $(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 1)($(__ARGV__ 1))" && return $(false)
	fi
	
	return $(true)	
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myVar "string"
	dk_call dk_info "dk_assertVar myVar" && dk_call dk_assertVar myVar
	#dk_call dk_info "dk_assertVar ${myVar}" && dk_call dk_assertVar ${myVar}

	dk_call dk_set myVarB 15
	dk_call dk_info "dk_assertVar myVarB" && dk_call dk_assertVar myVarB
	#dk_call dk_info "dk_assertVar ${myVarB}" && dk_call dk_assertVar ${myVarB}

	dk_call dk_set myVarC " "
	dk_call dk_info "dk_assertVar myVarC" && dk_call dk_assertVar myVarC
	#dk_call dk_info "dk_assertVar ${myVarC}" && dk_call dk_assertVar ${myVarC}

	dk_call dk_set myVarD ""
	dk_call dk_info "dk_assertVar myVarD" && dk_call dk_assertVar myVarD
	#dk_call dk_info "dk_assertVar ${myVarD}" && dk_call dk_assertVar ${myVarD}

	myVarE=
	dk_call dk_assertVar myVarE
	#dk_call dk_assertVar ${myVarE}

	dk_call dk_assertVar noVar
	#dk_call dk_assertVar ${noVar}
}
