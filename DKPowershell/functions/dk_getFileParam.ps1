if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getFileParam){ $dk_getFileParam = 1 } else{ return }

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
		echo "$($line[0]) = $($line[1])"
#		if ($line[0] -eq $args[1]) { 
#			Remove-Variable -Name $args[1] -Scope Global
#			echo "args1 = $($args[1])"
#			Set-Variable -Name $${($args[1])} -Value "$($line[1])" -Scope Global
#		}
	}
	
	echo "args0 = $($args[0])"
    echo "args1 = $($args[1])"
	echo "line0 = $($line[0])"
    echo "line1 = $($line[1])"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0
  
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKBRANCH_DIR"
    dk_call dk_getFileParam ${DKIMPORTS_DIR}/git/version.txt VERSION
	dk_call dk_printVar VERSION
}
