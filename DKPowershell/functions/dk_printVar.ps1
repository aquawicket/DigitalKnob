if (!($DKINIT)){ . $PWD\DK.ps1 }

if (! (Get-Variable 'USE_LOCAL_N_dk_printVar' -Scope 'Global' -ErrorAction 'Ignore')) {
	$global:USE_LOCAL_N_dk_printVar = 1
}

function Global:dk_printVar($var) {
	dk_debugFunc
	
	if (!($USE_LOCAL_N_dk_printVar -eq 1)){ return }
	$_value_ = (Get-Item variable:$var).Value
	Write-Output "$var = $_value_"
}


function Global:DKTEST() { ###########################################################################################
	
	$test_var = "a simple variable"
	dk_printVar test_var
}
