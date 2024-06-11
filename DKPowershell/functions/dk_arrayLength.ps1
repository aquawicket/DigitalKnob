if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayLength){ $dk_arrayLength = 1 } else{ return }

dk_load dk_error
dk_load dk_assert
################################################################################
# dk_arrayLength(array) -> rtn_var
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function Global:dk_arrayLength($array) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly -ErrorAction SilentlyContinue } 
	else { $_array_ = $array }
	
	return $_array_.count
}




function Global:DKTEST(){ ########################################################################
	dk_debugFunc
	
	$myArray = @('element 1', 'element 2', 'element 3')
	$length = dk_arrayLength myArray
	dk_echo "length = $length"
}