if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_assertPath){ $dk_assertPath = 1 } else{ return }

dk_load dk_pathExists
dk_load dk_error
################################################################################
# dk_assertPath(path)
#
function Global:dk_assertPath($path) {
    dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if(Test-Path variable:$path){
		$_path_ = (Get-Item variable:$path).Value	# from variable name
	} else {
		$_path_ = $path								# from variable
	}
	
	if(!(dk_pathExists $_path_)){		
		dk_error "Assertion failed: $_path_ is not found!"
		$assertPath = ${false}
	} 
	else { $assertPath = $true }
	dk_printVar assertPath
	return $assertPath

}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$sys32path = "C:/Windows/System32"
	dk_assertPath sys32path
	
	dk_assertPath "C:/NonExistentPath"
}
