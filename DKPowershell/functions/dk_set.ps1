if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_assert){ $dk_assert = 1 } else{ return }

dk_load dk_fixme
dk_fixme


dk_load dk_info
dk_load dk_error
dk_load dk_printVar
##################################################################################
# dk_set(<variable> <value>)
#
#
function Global:dk_set($variable, $value) {
	dk_debugFunc
	if($(__ARGC__) -lt 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	dk_info "variable = $variable"
	dk_info "value = $value"
	${!variable} = $value
	dk_printVar variable
}





function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_set myVar "value assigned with dk_set"	
	dk_info "myVar = ${myVar}"
}