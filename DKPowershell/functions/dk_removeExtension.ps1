if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_removeExtension){ $dk_removeExtension = 1 } else{ return } #include guard

##################################################################################
# dk_removeExtension(filepath) -> rtn_var
#
#
function Global:dk_removeExtension($filepath) {
	dk_debugFunc 1
	
	$removeExtension = $filepath.Substring(0, $filepath.lastIndexOf('.'))
	dk_call dk_printVar removeExtension
	return $removeExtension
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$filepath="C:/test/test2/xfile.version.1.2.ext"
	$name = dk_call dk_removeExtension $filepath
	dk_call dk_info "name = ${name}"
}
