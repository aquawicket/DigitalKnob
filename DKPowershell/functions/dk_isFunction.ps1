if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_isFunction){ $dk_isFunction = 1 } else{ return }

##############################################################################
# dk_isFunction(name rtn_var)
# 
#	Test if a string is a function name
#
#	@name	- The name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
function Global:dk_isFunction ($name){
	dk_debugFunc 
	
	if (Get-Command ${name} -errorAction SilentlyContinue) {
		$isfunction = 1
	}
	else{
		$isFunction = 0
	}
	
	dk_printVar isFunction
	return ${isFunction}
}



function test_function() {
	dk_info "..."
}

function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_echo "testing dk_isFunction(test_function)"
	$isFunction = dk_isFunction "test_function" 
	dk_info "isFunction = ${isFunction}" 
	
	dk_echo "testing dk_isFunction(nonExistentFunction)" 
	$isFunctionB = dk_isFunction "nonExistentFunction" 
	dk_info "isFunctionB = ${isFunctionB}"
}
