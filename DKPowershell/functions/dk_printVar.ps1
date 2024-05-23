if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_printVar){ $dk_printVar = 1 } else{ return }

dk_load dk_info
if (!$USE_LOCAL_N_dk_printVar){ $global:USE_LOCAL_N_dk_printVar = 1 }
####################################################################
# dk_printVar()
#
#
function Global:dk_printVar($var) {
	dk_debugFunc
	
	if(!$USE_LOCAL_N_dk_printVar){ return }
	$_value_ = (Get-Item variable:$var).Value
	dk_info "$var = $_value_"
}


function Global:DKTEST() { ###########################################################################################
	
	$test_var = "a simple variable"
	dk_printVar test_var
}
