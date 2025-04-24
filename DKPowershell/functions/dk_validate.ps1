<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_validate){ $dk_validate = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_validate){ $dk_validate = 1 } else{ return } #include guard
>>>>>>> Development

###############################################################################
# dk_validate(variable, code)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid.
#
function Global:dk_validate($variable, $code) {
	dk_debugFunc 2
	
	if($variable -and (Test-Path variable:$variable)){ return }
	
	if($code -and (Test-Path $code -PathType Leaf)){ dk_call dk_load $code }
	
	#eval "${code}"
	if($code){ Invoke-Expression $code }
	if(!(Test-Path variable:$variable)){ dk_call dk_error "dk_validate(): $variable is invalid" }
	
	dk_call dk_printVar $variable
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myVarA="a valid variable"
	dk_call dk_validate myVarA "fill_myVarA"
	dk_call dk_echo "myVarA = ${myVarA}"
		
	dk_call dk_validate myVarB "fill_myVarB"
	dk_call dk_echo "myVarB = ${myVarB}"
	
	dk_call dk_validate myVarC "myVarC='a string value'"
	dk_call dk_echo "myVarC = ${myVarC}"
	
	dk_call dk_validate myVarD "dk_call dk_echo 'this will not fill myVarD'"
	dk_call dk_echo "myVarD = ${myVarD}"
}

function Global:fill_myVarA() {
	$myVarA="myVarA has a string value"
}

function Global:fill_myVarB() {
	$myVarB="myVarB has a string value"
}