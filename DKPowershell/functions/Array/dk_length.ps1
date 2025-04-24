if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$Array_dk_length){ $Array_dk_length = 1 } else{ return } #include guard

################################################################################
# Array:dk_length(array) -> rtn_var
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function Global:Array:dk_length($array) {
	dk_debugFunc 1
	
	if($null -eq $array){ $arrayLength = 0; dk_printVar arrayLength; return $arrayLength }
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly -ErrorAction SilentlyContinue } 
	else {
		$_array_ = $array 
		if(!($_array_.count -gt 1)){
			dk_call dk_warning "Array:dk_length($array): are you sure the parameter is an array?"
			$arrayLength = 0; dk_printVar arrayLength; return $arrayLength
		}
	}
	if($null -eq $_array_){ $arrayLength = 0; dk_printVar arrayLength; return $arrayLength }

	$arrayLength = $_array_.count
	dk_printVar arrayLength
	return $arrayLength
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	
	$myArray = @('element 1', 'element 2', 'element 3')
	$length = Array:dk_length myArray
	dk_echo "length = $length"
	
	$myArrayB = @('element A', 'element B', 'element C')
	$lengthB = Array:dk_length myArrayB
	dk_echo "lengthB = $lengthB"
	
	$myArrayC = @()
	$lengthC = Array:dk_length myArrayC
	dk_echo "lengthC = $lengthC"
	
	$myArrayD = ""
	$lengthD = Array:dk_length myArrayD
	dk_echo "lengthD = $lengthD"
	
	$lengthZ = Array:dk_length myArrayZ
	dk_echo "lengthZ = $lengthZ"
	dk_printVar myArrayZ
}