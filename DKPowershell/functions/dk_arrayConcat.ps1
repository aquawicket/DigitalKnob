if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

################################################################################
# dk_arrayConcat(array, value1, value2, /* …, */ valueN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_concat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
function Global:dk_arrayConcat($array, $value1) {
	dk_debugFunc 2 99
	
	if(Test-Path variable:$array){ $_array_ = Get-Variable -Name ($array) -ValueOnly } 
	else { $_array_ = $array }
	
	dk_call dk_todo
}







function Global:DKTEST(){ ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc 0
	
	dk_call dk_arrayConcat array value1
}
