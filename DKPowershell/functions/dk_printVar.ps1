if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_printVar){ $dk_printVar = 1 } else{ return }

dk_load dk_color
dk_load dk_debug
####################################################################
# dk_printVar()
#
#
function Global:dk_printVar($var) {
	dk_debugFunc
	
	if(Test-Path variable:$var){
		$_name_ = (Get-Item variable:$var).Name
		$_value_ = (Get-Item variable:$var).Value
		dk_debug "$_name_ = '$_value_'"
	}
	else {
		dk_debug "$var = ${red}UNDEFINED${clr}"
	}
}


function Global:DKTEST() { ###########################################################################################
	
	$test_var = "a simple variable"
	dk_printVar test_var
}
