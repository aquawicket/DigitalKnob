#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_assert(<expression>)
#
#
dk_assert() {
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	#_expression_="$1"
	#if ( [ ! -n "${!_expression_-}" ]   ||
    #     [ -z "${!_expression_}" ]     ||
    #     [ ! -n "${!_expression_+x}" ] )
	
	if ( [ ! -n "${!1-}" ]   ||
         [ -z "${!1}" ]     ||
         [ ! -n "${!1+x}" ] )
	then
		lastErrorFile="${BASH_SOURCE[1]}"
		export lastErrorFile=$(realpath ${lastErrorFile})
		export lastErrorLine="${BASH_LINENO[1-1]}"
		dk_error "Assertion failed: $1" && return ${false}
	fi
	
	return ${true}	
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_echo "testing dk_assert . . ."

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