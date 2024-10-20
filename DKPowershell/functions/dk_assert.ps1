if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_assert){ $dk_assert = 1 } else{ return }

##################################################################################
# dk_assert(expression)
#
#
function Global:dk_assert($expression) {
	dk_debugFunc 1

	if(!(${!expression})){
		dk_call dk_error "Assertion failed: $(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 1)($(__ARGV__ 1))"
		return ${false}
	}
	
	return ${true}	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myVar = "string"
	dk_call dk_info "dk_assert myVar" -and dk_call dk_assert myVar
	#dk_call dk_info "dk_assert $myVar" -and dk_call dk_assert $myVar
	#dk_call dk_info "dk_assert ${myVar}" -and dk_call dk_assert ${myVar}

	$myVarB = 15
	dk_call dk_info "dk_assert myVarB" -and dk_call dk_assert myVarB
	#dk_call dk_info "dk_assert $myVarB" -and dk_call dk_assert $myVarB
	#dk_call dk_info "dk_assert ${myVarB}" -and dk_call dk_assert ${myVarB}

	$myVarC = " "
	dk_call dk_info "dk_assert myVarC" -and dk_call dk_assert myVarC
	#dk_call dk_info "dk_assert $myVarC" -and dk_call dk_assert $myVarC
	#dk_call dk_info "dk_assert ${myVarC}" -and dk_call dk_assert ${myVarC}

	$myVarD = ""
	dk_call dk_info "dk_assert myVarD" -and dk_call dk_assert myVarD
	#dk_call dk_info "dk_assert $myVarD" -and dk_call dk_assert $myVarD
	#dk_call dk_info "dk_assert ${myVarD}" -and dk_call dk_assert ${myVarD}

	$myVarE =
	dk_call dk_assert myVarE
	#dk_call dk_assert $myVarE
	#dk_call dk_assert ${myVarE}

	dk_call dk_assert noVar
	#dk_call dk_assert $noVar
	#dk_call dk_assert ${noVar}
}