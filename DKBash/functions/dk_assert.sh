#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_assert(expression)
#
#
dk_assert() {
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
	dk_call dk_info "dk_assert myVar" && dk_call dk_assert myVar
	#dk_call dk_info "dk_assert ${myVar}" && dk_call dk_assert ${myVar}

	dk_call dk_set myVarB 15
	dk_call dk_info "dk_assert myVarB" && dk_call dk_assert myVarB
	#dk_call dk_info "dk_assert ${myVarB}" && dk_call dk_assert ${myVarB}

	dk_call dk_set myVarC " "
	dk_call dk_info "dk_assert myVarC" && dk_call dk_assert myVarC
	#dk_call dk_info "dk_assert ${myVarC}" && dk_call dk_assert ${myVarC}

	dk_call dk_set myVarD ""
	dk_call dk_info "dk_assert myVarD" && dk_call dk_assert myVarD
	#dk_call dk_info "dk_assert ${myVarD}" && dk_call dk_assert ${myVarD}

	myVarE=
	dk_call dk_assert myVarE
	#dk_call dk_assert ${myVarE}

	dk_call dk_assert noVar
	#dk_call dk_assert ${noVar}
}
