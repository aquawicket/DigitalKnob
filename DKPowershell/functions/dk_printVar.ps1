if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_printVar){ $dk_printVar = 1 } else{ return }

dk_load dk_info
####################################################################
# dk_printVar()
#
#
function Global:dk_printVar($var) {
	dk_debugFunc
	
	if(Test-Path variable:$var){
		$_value_ = (Get-Item variable:$var).Value
		dk_info "$var = $_value_"
	}
	else {
		dk_info "$var = UNDEFINED"
	}
}


function Global:DKTEST() { ###########################################################################################
	
	$test_var = "a simple variable"
	dk_printVar test_var
}
