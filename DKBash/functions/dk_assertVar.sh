#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
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
