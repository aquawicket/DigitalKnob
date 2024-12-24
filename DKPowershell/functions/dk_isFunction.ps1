if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##############################################################################
# dk_isFunction(name rtn_var)
# 
#	Test if a string is a function name
#
#	@name	- The name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
function Global:dk_isFunction ($name){
	dk_debugFunc 1 2
	
	if (Get-Command ${name} -errorAction SilentlyContinue) {
		$isfunction = 1
	}
	else{
		$isFunction = 0
	}
	
	dk_call dk_printVar isFunction
	return ${isFunction}
}












function test_function() {
	dk_call dk_info "..."
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {###
	dk_debugFunc 0
	
	dk_call dk_echo "testing dk_isFunction(test_function)"
	$isFunction = dk_call dk_isFunction "test_function" 
	dk_call dk_info "isFunction = ${isFunction}" 
	
	dk_call dk_echo "testing dk_isFunction(nonExistentFunction)" 
	$isFunctionB = dk_call dk_isFunction "nonExistentFunction" 
	dk_call dk_info "isFunctionB = ${isFunctionB}"
}
