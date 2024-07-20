if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getFiles){ $dk_getFiles = 1 } else{ return }

################################################################################
# dk_getFiles(path) return -> rtn_var
#
#
#
function Global:dk_getFiles($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	$files = Get-ChildItem $path | Where-Object {$_.PSIsContainer -eq $false} | Foreach-Object {$_.Name}
	dk_printVar files
	return $files
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	$files = dk_getFiles "C:/Windows"
	dk_echo "files = $files"
}	