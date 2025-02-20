if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$Array_dk_copyWithin){ $Array_dk_copyWithin = 1 } else{ return } #include guard

################################################################################
# Array:dk_copyWithin(array, target, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
function Global:Array:dk_copyWithin($array, $target, $start, $end) {
	dk_debugFunc 4
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_call dk_todo "Array:dk_copyWithin"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call Array:dk_copyWithin array target start end
}
