if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_fileSHA256){ $dk_fileSHA256 = 1 } else{ return } #include guard


################################################################################
# dk_fileSHA256(filepath)
#
#
function Global:dk_fileSHA256() {
	dk_debugFunc 0 99;

	#$all_args = $PsBoundParameters.Values + ${args};
	#arg1 = $($args[0]);
	#arg2 = $($args[1]);
	
	$hash = (Get-FileHash $($args[0]) -Algorithm SHA256).Hash;
	return $hash
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_fileSHA256 "${DKBATCH_FUNCTIONS_DIR}/DK.cmd"
}
