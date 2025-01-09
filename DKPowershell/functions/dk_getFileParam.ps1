if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

################################################################################
# dk_getFileParam(file, var_name) value
#
# todo: add optional 3rd parameter for output value
function Global:dk_getFileParam() {
    dk_debugFunc 0
	
	$file = $args[0]
	$var_name = $args[1]
	
	Get-Content $file | ForEach-Object {
		$line = $_ -split '='
		
		#echo "file = $file"
		#echo "var_name = $var_name"
		#echo "line0 = $($line[0])"
		#echo "line1 = $($line[1])"
		
		if ("$($line[0])" -eq "$var_name") { 
			#Remove-Variable -Name $args[1] -Scope Global
			Set-Variable -Name "$var_name" -Value "$($line[1])" -Scope Global
			return "$($line[1])"
		}
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0
  
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
    $VERSION = $(dk_getFileParam ${DKIMPORTS_DIR}/git/version.txt VERSION)
	#dk_call dk_getFileParam "${DKIMPORTS_DIR}/git/version.txt" VERSION
	dk_call dk_printVar VERSION
}
