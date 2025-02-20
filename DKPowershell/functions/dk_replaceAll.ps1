if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_replaceAll){ $dk_replaceAll = 1 } else{ return } #include guard

##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll($str, $searchValue, $newValue) {
	dk_debugFunc 3

	$replaceAll = $str -replace $searchValue, $newValue
	
	dk_call dk_printVar replaceAll
	return $replaceAll
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$string_var="AZC AZC Zannana Zread"
	dk_call dk_info "string before:  ${string_var}"
	
	$string_var = dk_call dk_replaceAll $string_var "Z" "B"
	dk_call dk_info "string after:  ${string_var}"
}
