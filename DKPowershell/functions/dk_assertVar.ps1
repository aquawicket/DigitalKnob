if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_assertVar_ps1){ $dk_assertVar_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_assertVar(expression)
#
#
function Global:dk_assertVar() {
	#dk_debugFunc 1;

	${var}=$args[0];
	
	if(Test-Path variable:${var}){ return; }
	
	#Write-Host "var = ${var} = $(gv -Name ${var} -ValueOnly)"
	
	dk_call dk_error "Assertion failed: $(__FILE__ 1):$(__LINE__ 1)  $(__FUNCTION__ 1)($(__ARGV__ 1))";
	return ${false};
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	$myVar = "string";
	dk_call dk_info "dk_assertVar myVar = ${myVar}"; dk_call dk_assertVar myVar;
	#dk_call dk_info "dk_assertVar $myVar"; dk_call dk_assertVar $myVar;
	#dk_call dk_info "dk_assertVar ${myVar}"; dk_call dk_assertVar ${myVar};

	$myVarB = 15;
	dk_call dk_info "dk_assertVar myVarB = ${myVarB}"; dk_call dk_assertVar myVarB;
	#dk_call dk_info "dk_assertVar $myVarB"; dk_call dk_assertVar $myVarB;
	#dk_call dk_info "dk_assertVar ${myVarB}"; dk_call dk_assertVar ${myVarB};

	$myVarC = " ";
	dk_call dk_info "dk_assertVar myVarC = ${myVarC}"; dk_call dk_assertVar myVarC;
	#dk_call dk_info "dk_assertVar $myVarC"; dk_call dk_assertVar $myVarC;
	#dk_call dk_info "dk_assertVar ${myVarC}"; dk_call dk_assertVar ${myVarC};

	#$myVarD = "";
	dk_call dk_info "dk_assertVar myVarD = ${myVarD}"; dk_call dk_assertVar myVarD;
	#dk_call dk_info "dk_assertVar $myVarD"; dk_call dk_assertVar $myVarD;
	#dk_call dk_info "dk_assertVar ${myVarD}"; dk_call dk_assertVar ${myVarD};

#	$myVarE =;
#	dk_call dk_assertVar myVarE;
#	#dk_call dk_assertVar $myVarE;
#	#dk_call dk_assertVar ${myVarE};

#	dk_call dk_assertVar noVar;
#	#dk_call dk_assertVar $noVar;
#	#dk_call dk_assertVar ${noVar};
}