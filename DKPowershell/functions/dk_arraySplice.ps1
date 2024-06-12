if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayIndexOf){ $dk_arrayIndexOf = 1 } else{ return }

################################################################################
# dk_arraySplice(array, start, deleteCount, item1, item2, /* …, */ itemN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_splice
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice
#
function Global:dk_arraySplice () {
	call dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_todo "dk_arraySplice"
}




function Global:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	#  TODO
	dk_arraySplice array start
}