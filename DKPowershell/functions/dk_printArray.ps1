if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_printArray){ $dk_printArray = 1 } else{ return }

################################################################################
# dk_printArray(array)
#
#
function Global:dk_printArray($array) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	if(Test-Path variable:$array){ 
		$_array_ = Get-Variable -Name ($array) -ValueOnly		# from variable name
		$_name_ = $array
	}
	else { 
		$_array_ = $array										# from variable
		$_name_ = '$array'
	}
	
	for($i=0; $i -lt $_array_.count; $i++) {
		$value = $_array_[$i]
		dk_echo "$_name_[$i]  $value"
	}
	dk_info "$_name_ length = $i"
}




function Global:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	dk_printArray myArray
	
	$myArrayB = @('1', '2', '3', '4', '5')
	dk_printArray $myArrayB
}