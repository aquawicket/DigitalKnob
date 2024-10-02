if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_assertVar){ $dk_assertVar = 1 } else{ return }

##################################################################################
# dk_assertVar(expression)
#
#
function Global:dk_assertVar($expression) {
	dk_debugFunc 1

	if((${!expression})){
		return #${true}
	}
	
	dk_call dk_error "Assertion failed: $(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 1)($(__ARGV__ 1))"
	return ${false}	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myVar = "string"
	dk_call dk_info "dk_assertVar myVar" -and dk_call dk_assertVar myVar
	#dk_call dk_info "dk_assertVar $myVar" -and dk_call dk_assertVar $myVar
	#dk_call dk_info "dk_assertVar ${myVar}" -and dk_call dk_assertVar ${myVar}

	$myVarB = 15
	dk_call dk_info "dk_assertVar myVarB" -and dk_call dk_assertVar myVarB
	#dk_call dk_info "dk_assertVar $myVarB" -and dk_call dk_assertVar $myVarB
	#dk_call dk_info "dk_assertVar ${myVarB}" -and dk_call dk_assertVar ${myVarB}

	$myVarC = " "
	dk_call dk_info "dk_assertVar myVarC" -and dk_call dk_assertVar myVarC
	#dk_call dk_info "dk_assertVar $myVarC" -and dk_call dk_assertVar $myVarC
	#dk_call dk_info "dk_assertVar ${myVarC}" -and dk_call dk_assertVar ${myVarC}

	$myVarD = ""
	dk_call dk_info "dk_assertVar myVarD" -and dk_call dk_assertVar myVarD
	#dk_call dk_info "dk_assertVar $myVarD" -and dk_call dk_assertVar $myVarD
	#dk_call dk_info "dk_assertVar ${myVarD}" -and dk_call dk_assertVar ${myVarD}

	$myVarE =
	dk_call dk_assertVar myVarE
	#dk_call dk_assertVar $myVarE
	#dk_call dk_assertVar ${myVarE}

	dk_call dk_assertVar noVar
	#dk_call dk_assertVar $noVar
	#dk_call dk_assertVar ${noVar}
}