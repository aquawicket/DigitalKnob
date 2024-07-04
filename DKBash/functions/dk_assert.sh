#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_assert(expression)
#
#
dk_assert (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	if ( [ ! -n "${!1-}" ]  ||
         [ -z "${!1}" ]     ||
         [ ! -n "${!1+x}" ] )
	then
		dk_error "Assertion failed: $(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 1)($(__ARGV__ 1))" && return ${false}
	fi
	
	return ${true}	
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_set myVar "string"
	dk_info "dk_assert myVar" && dk_assert myVar
	#dk_info "dk_assert $myVar" && dk_assert $myVar
	#dk_info "dk_assert ${myVar}" && dk_assert ${myVar}

	dk_set myVarB 15
	dk_info "dk_assert myVarB" && dk_assert myVarB
	#dk_info "dk_assert $myVarB" && dk_assert $myVarB
	#dk_info "dk_assert ${myVarB}" && dk_assert ${myVarB}

	dk_set myVarC " "
	dk_info "dk_assert myVarC" && dk_assert myVarC
	#dk_info "dk_assert $myVarC" && dk_assert $myVarC
	#dk_info "dk_assert ${myVarC}" && dk_assert ${myVarC}

	dk_set myVarD ""
	dk_info "dk_assert myVarD" && dk_assert myVarD
	#dk_info "dk_assert $myVarD" && dk_assert $myVarD
	#dk_info "dk_assert ${myVarD}" && dk_assert ${myVarD}

	myVarE=
	dk_assert myVarE
	#dk_assert $myVarE
	#dk_assert ${myVarE}

	dk_assert noVar
	#dk_assert $noVar
	#dk_assert ${noVar}
}