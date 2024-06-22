if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_set){ $dk_set = 1 } else{ return }

##################################################################################
# dk_set(variable value)
#
#
function Global:dk_set($variable, $value) {
	dk_debugFunc
	if($(__ARGC__) -lt 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	Set-Variable -Name $variable -Value $value -Scope Global
	
	dk_printVar $variable
}





function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_set myVar "value assigned with dk_set"	
	dk_info "myVar = ${myVar}"
}