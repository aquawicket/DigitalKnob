if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayConcat){ $dk_arrayConcat = 1 } else{ return }

dk_load dk_todo
dk_load dk_error
################################################################################
# dk_arrayConcat(array, value1, value2, /* …, */ valueN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_concat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
function Global:dk_arrayConcat($array, $value1) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_todo "dk_arrayConcat"
}




function Global:DKTEST(){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_arrayConcat array value1
}