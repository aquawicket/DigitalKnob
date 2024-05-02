#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_assert(expression)
#
#
dk_assert() {
	dk_debugFunc
	#echo "dk_assert($*)"
	[ -z $1 ] && dk_error "Assertion failed: $1"
	return $true	
}




################################ DKTEST #########################################
[ -n "$DKTEST" ] && {
	dk_echo "testing dk_assert . . ."

	myVar="string"
	echo "dk_assert myVar" && dk_assert myVar
	echo "dk_assert $myVar" && dk_assert $myVar
	echo "dk_assert ${myVar}" && dk_assert ${myVar}

	myVarB=15
	echo "dk_assert myVarB" && dk_assert myVarB
	echo "dk_assert $myVarB" && dk_assert $myVarB
	echo "dk_assert ${myVarB}" && dk_assert ${myVarB}

	myVarC=" "
	echo "dk_assert myVarC" && dk_assert myVarC
	echo "dk_assert $myVarC" && dk_assert $myVarC
	echo "dk_assert ${myVarC}" && dk_assert ${myVarC}

	myVarD=""
	echo "dk_assert myVarD" && dk_assert myVarD
	echo "dk_assert $myVarD" && dk_assert $myVarD
	echo "dk_assert ${myVarD}" && dk_assert ${myVarD}

	myVarE=
	dk_assert myVarE
	dk_assert $myVarE
	dk_assert ${myVarE}

	dk_assert noVar
	dk_assert $noVar
	dk_assert ${noVar}
	
} && exec $SHELL