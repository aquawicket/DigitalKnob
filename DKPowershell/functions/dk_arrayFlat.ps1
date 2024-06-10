if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayFlat){ $dk_arrayFlat = 1 } else{ return }

dk_load dk_error
dk_load dk_todo
################################################################################
# dk_arrayFlat(array depth)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_flat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/flat
#
function Global:dk_arrayFlat($array, $depth) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_todo "dk_arrayFlat"
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_arrayFlat array depth
}