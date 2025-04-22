if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_getFileParam){ $dk_getFileParam = 1 } else{ return } #include guard

################################################################################
# dk_getAllFileParams(filepath)
#
# todo: add optional 3rd parameter for output value
function Global:dk_getAllFileParams() {
    dk_debugFunc 0
	
	$file = $args[0]
	
	Get-Content $file | ForEach-Object {
		$line = $_ -split '='
		
		#echo "file = $file"
		#echo "var_name = $var_name"
		#echo "line0 = $($line[0])"
		#echo "line1 = $($line[1])"
		
		#Remove-Variable -Name $args[1] -Scope Global
		dk_call dk_echo "$($line[0]) = $($line[1])"
		Set-Variable -Name "$($line[0])" -Value "$($line[1])" -Scope Global
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0
  
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
    $VERSION = $(dk_getAllFileParams ${DKBRANCH_DIR}/dkconfig.txt)
	dk_call dk_printVar dk_getAllFileParams_ENABLE
}
