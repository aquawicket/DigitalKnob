if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_generate){ $dk_generate = 1 } else{ return }

dk_load dk_error
##################################################################################
# dk_unset(<variable>)
#
#
function Global:dk_unset($variable) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	Clear-Variable $variable -Scope Global
	#Clear-Variable $variable -Scope Local
	#Clear-Variable $variable -Scope Script
}





function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$global:myVar = "initial value assigned with dk_unset"
	echo "myVar = ${myVar}"
	dk_unset myVar
	echo "myVar = ${myVar}"
}