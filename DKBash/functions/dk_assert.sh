#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_assert(expression)
#
#
dk_assert() {
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




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myVar="string"
	echo "dk_assert myVar" && dk_assert myVar
	#echo "dk_assert $myVar" && dk_assert $myVar
	#echo "dk_assert ${myVar}" && dk_assert ${myVar}

	myVarB=15
	echo "dk_assert myVarB" && dk_assert myVarB
	#echo "dk_assert $myVarB" && dk_assert $myVarB
	#echo "dk_assert ${myVarB}" && dk_assert ${myVarB}

	myVarC=" "
	echo "dk_assert myVarC" && dk_assert myVarC
	#echo "dk_assert $myVarC" && dk_assert $myVarC
	#echo "dk_assert ${myVarC}" && dk_assert ${myVarC}

	myVarD=""
	echo "dk_assert myVarD" && dk_assert myVarD
	#echo "dk_assert $myVarD" && dk_assert $myVarD
	#echo "dk_assert ${myVarD}" && dk_assert ${myVarD}

	myVarE=
	dk_assert myVarE
	#dk_assert $myVarE
	#dk_assert ${myVarE}

	dk_assert noVar
	#dk_assert $noVar
	#dk_assert ${noVar}
}