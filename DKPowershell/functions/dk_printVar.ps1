if (!($DKINIT)){ . $PWD\DK.ps1 }

#[ -z ${USE_LOCAL_N_dk_printVar-} ] && export USE_LOCAL_N_dk_printVar=0
if (! (Get-Variable 'USE_LOCAL_N_dk_printVar' -Scope 'Global' -ErrorAction 'Ignore')) {
	$global:USE_LOCAL_N_dk_printVar = 0
}

function Global:dk_printVar () {
	dk_debugFunc
	
}



