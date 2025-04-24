if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_fileMD5){ $dk_fileMD5 = 1 } else{ return } #include guard


################################################################################
# dk_fileMD5(filepath)
#
#
function Global:dk_fileMD5() {
	dk_debugFunc 0 99;

	#$all_args = $PsBoundParameters.Values + ${args};
	#arg1 = $($args[0]);
	#arg2 = $($args[1]);
	
	$hash = (Get-FileHash $($args[0]) -Algorithm MD5).Hash;
	return $hash
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_validate DKBATCH_FUNCTIONS_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_fileMD5 "${DKBATCH_FUNCTIONS_DIR}/DK.cmd"
}
