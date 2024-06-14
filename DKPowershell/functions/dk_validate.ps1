if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_validate){ $dk_validate = 1 } else{ return }


###############################################################################
# dk_validate(<variable> <code>)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid.
#
function Global:dk_validate($variable, $code) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if($variable -and (Test-Path variable:$variable)){ return }
	
	if($code -and (Test-Path $code -PathType Leaf)){ dk_load $code }
	
	#eval "${code}"
	Invoke-Expression $code
	if(!(Test-Path variable:$variable)){ dk_error "dk_validate(): $variable is invalid" }
	
	dk_printVar $variable
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$myVarA="a valid variable"
	dk_validate myVarA fill_myVarA
	echo "myVarA = ${myVarA}"
		
	dk_validate myVarB fill_myVarB
	echo "myVarB = ${myVarB}"
	
	dk_validate myVarC "myVarC='a string value'"
	echo "myVarC = ${myVarC}"
	
	dk_validate myVarD "echo 'this will not fill myVarD'"
	echo "myVarD = ${myVarD}"
}

function Global:fill_myVarA() {
	$myVarA="myVarA has a string value"
}

function Global:fill_myVarB() {
	$myVarB="myVarB has a string value"
}