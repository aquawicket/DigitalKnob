if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_arrayLength){ $dk_arrayLength = 1 } else{ return }

dk_load dk_error
dk_load dk_assert
dk_load dk_warning
################################################################################
# dk_arrayLength(array) -> rtn_var
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function Global:dk_arrayLength($array) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if($null -eq $array){ return 0 }
	#if(!($array.count -gt 0)){ return 0 }
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly -ErrorAction SilentlyContinue } 
	else {
		$_array_ = $array 
		if(!($_array_.count -gt 1)){
			dk_warning "dk_arrayLength($array): are you sure the parameter is an array?"
			return 0 
		}
	}
	if($null -eq $_array_){ return 0 }
	#if(!($_array_.count -gt 0)){ return 0 }
	return $_array_.count
}




function Global:DKTEST(){ ########################################################################
	dk_debugFunc
	
	$myArray = @('element 1', 'element 2', 'element 3')
	$length = dk_arrayLength myArray
	dk_echo "length = $length"
	
	$myArrayB = @('element A', 'element B', 'element C')
	$lengthB = dk_arrayLength myArrayB
	dk_echo "lengthB = $lengthB"
	
	$myArrayC = @()
	$lengthC = dk_arrayLength myArrayC
	dk_echo "lengthC = $lengthC"
	
	$myArrayD = ""
	$lengthD = dk_arrayLength myArrayD
	dk_echo "lengthD = $lengthD"
	
	$lengthZ = dk_arrayLength myArrayZ
	dk_echo "lengthZ = $lengthZ"
	dk_printVar myArrayZ
}