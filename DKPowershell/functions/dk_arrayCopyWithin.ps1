if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_arrayCopyWithin){ $dk_arrayCopyWithin = 1 } else{ return }

################################################################################
# dk_arrayCopyWithin(array, target, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
function Global:dk_arrayCopyWithin($array, $target, $start, $end) {
	dk_debugFunc
	if($(__ARGC__) -ne 4){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_todo "dk_arrayCopyWithin"
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_arrayCopyWithin array target start end
}