if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$Array_dk_join){ $Array_dk_join = 1 } else{ return } #include guard

################################################################################
# Array:dk_join(array, separator) -> rtn_var
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
function Global:Array:dk_join($array, $separator) {
	dk_debugFunc 2
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 	# from variable name
	else { $_array_ = $array }															# from variable
	
	$arrayJoin = $_array_ -join $separator
	
	dk_call dk_printVar arrayJoin
	return $arrayJoin
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() {
	dk_debugFunc 0
	
	$myArray = @('a', 'b', 'c', 'd', 'e')
	
	$myString = dk_call Array:dk_join myArray ","
	dk_call dk_info "myString = $myString"
}
