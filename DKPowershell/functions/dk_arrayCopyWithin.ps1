if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_arrayCopyWithin){ $dk_arrayCopyWithin = 1 } else{ return } #include guard

################################################################################
# dk_arrayCopyWithin(array, target, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
function Global:dk_arrayCopyWithin($array, $target, $start, $end) {
	dk_debugFunc 4
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_call dk_todo "dk_arrayCopyWithin"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_arrayCopyWithin array target start end
}
