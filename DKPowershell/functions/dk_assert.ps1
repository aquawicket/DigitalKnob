if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_assert){ $dk_assert = 1 } else{ return }

##################################################################################
# dk_assert(<expression>)
#
#
function Global:dk_assert($expression) {
	dk_debugFunc
	if ( $(__ARGC__) -lt 1 ){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if ( ! ${!expression} ){
		$lastErrorFile = "$(__FILE__ 1)"
		#export lastErrorFile=$(realpath ${lastErrorFile})
		dk_realpath ${lastErrorFile} lastErrorFile
		export lastErrorLine="$(__LINE__ 0)"
		dk_error "Assertion failed: $1" && return ${false}
	}
	
	return ${true}	
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_load dk_echo
	dk_echo "testing dk_assert . . ."

	$myVar="string"
	echo "dk_assert myVar" && dk_assert myVar
	#echo "dk_assert $myVar" && dk_assert $myVar
	#echo "dk_assert ${myVar}" && dk_assert ${myVar}

	$myVarB=15
	echo "dk_assert myVarB" && dk_assert myVarB
	#echo "dk_assert $myVarB" && dk_assert $myVarB
	#echo "dk_assert ${myVarB}" && dk_assert ${myVarB}

	$myVarC=" "
	echo "dk_assert myVarC" && dk_assert myVarC
	#echo "dk_assert $myVarC" && dk_assert $myVarC
	#echo "dk_assert ${myVarC}" && dk_assert ${myVarC}

	$myVarD=""
	echo "dk_assert myVarD" && dk_assert myVarD
	#echo "dk_assert $myVarD" && dk_assert $myVarD
	#echo "dk_assert ${myVarD}" && dk_assert ${myVarD}

	$myVarE=
	dk_assert myVarE
	#dk_assert $myVarE
	#dk_assert ${myVarE}

	dk_assert noVar
	#dk_assert $noVar
	#dk_assert ${noVar}
}