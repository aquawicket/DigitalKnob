<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_assertPath){ $dk_assertPath = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . './DK.ps1' }
if(!$dk_assertPath){ $dk_assertPath = 1 } else{ return } #include guard
>>>>>>> Development

################################################################################
# dk_assertPath(path)
#
function Global:dk_assertPath($path) {
    dk_debugFunc 1

	if(Test-Path variable:$path){
		$_path_ = (Get-Item variable:$path).Value	# from variable name
	} else {
		$_path_ = $path								# from variable
	}
	
	if((dk_call dk_pathExists $_path_)){		
		return #${true}
	} 
	
	dk_call dk_error "Assertion failed: $_path_ is not found!"
	return ${false}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$sys32path = "C:/Windows/System32"
	dk_call dk_assertPath "C:/Windows/System32"
	dk_call dk_assertPath sys32path
	dk_call dk_assertPath $sys32path
	dk_call dk_assertPath "$sys32path"
	dk_call dk_assertPath "sys32path"
	
	dk_call dk_assertPath "C:/NonExistentPath"
}
